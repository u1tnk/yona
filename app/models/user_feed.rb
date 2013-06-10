# == Schema Information
#
# Table name: user_feeds
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  feed_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class UserFeed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed

  def self.unreads(user)
    user.user_feeds.includes(:feed).select {|uf| uf.unread_articles_count > 0}
  end

  def unread_articles_count
    feed.articles_count - ArticleReadLog.where(user: user, feed: feed).count
  end

  def self.select_by_tag(user_feeds, tag)
    user_feeds.select{|uf| tag.feeds.include? uf.feed}
  end
end
