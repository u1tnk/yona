# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  title      :string(255)
#  html_url   :string(255)
#  kind       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Feed < ActiveRecord::Base
  belongs_to :user

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
end
