# == Schema Information
#
# Table name: feeds
#
#  id               :integer          not null, primary key
#  url              :string(255)
#  title            :string(255)
#  html_url         :string(255)
#  kind             :string(255)
#  creator          :string(255)
#  etag             :string(255)
#  last_modified_at :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

class Feed < ActiveRecord::Base
  belongs_to :user
  has_many :feed_tags
  has_many :articles

  def tags(user)
    tag_ids = feed_tags.pluck(:tag_id)
    Tag.where("id in (?)", tag_ids)
  end

  def self.import(user, xml_string)
    data = Hashie::Mash.new Hash.from_xml(xml_string)

    transaction do
      self.import_outline(user, data.opml.body.outline, nil)
    end
  end

  def self.import_outline(user, node, parent)
    if node.is_a? Array
      node.map{|r| import_outline(user, r, parent)}
    elsif node.outline
      import_outline(user, node.outline, node)
    else
      feed = Feed.where(url: node.xmlUrl).first_or_create({
        title: node.title,
        html_url: node.htmlUrl,
        # opml importでは固定
        kind: :rss,
      })
      UserFeed.where(
        user_id: user.id,
        feed_id: feed.id,
      ).first_or_create

      if parent
        tag = Tag.where(
          user_id: user.id,
          label: parent.title,
        ).first_or_create

        FeedTag.where(
          feed_id: feed.id,
          tag_id: tag.id,
        ).first_or_create

      end
    end
  end

  def self.fetch_all
    transaction do
      Feed.all.map(&:fetch)
    end
  end

  def fetch
    data = nil
    begin
      options = {}
      options[:if_modified_since] = last_modified_at if last_modified_at
      options[:if_none_match] = etag if etag

      data = Feedzirra::Feed.fetch_and_parse(url, options)
    rescue => error
      logger.warn "fetch error:" + url + " " + error.to_s
      return
    end

    unless data.is_a? Feedzirra::Parser::RSS
      logger.debug "no updated data: " + url
      return
    end
    return if self.last_modified_at && last_modified_at >= data.last_modified

    # vim-users.jpのデータが取得できないがnilにはならない
    return unless data.title

    self.title = data.title
    self.etag  = data.etag
    self.last_modified_at = data.last_modified
    self.save!

    data.entries.map do |e|
      article = Article.where(url: e.url).first

      if article
        next if article.published_at >= e.published
        # TODO 既読削除
        article.update_attributes!(
          title: e.title,
          summary: e.summary,
          author: e.author,
          url: e.url,
          published_at: e.published,
        )
      else
        Article.create(
          feed: self,
          title: e.title,
          summary: e.summary,
          author: e.author,
          url: e.url,
          published_at: e.published,
        )
      end
    end
  end

  def self.load_test
    raise unless Rails.env.development?
    user = User.where(id: 1).first_or_create
    Feed.import(user, File.open(Rails.root.to_s + "/doc/sample.xml").read)
  end
end
