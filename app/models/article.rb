# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  feed_id      :integer          not null
#  title        :string(255)      not null
#  url          :string(255)      not null
#  content      :text(16777215)
#  author       :string(255)
#  published_at :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Article < ActiveRecord::Base
  belongs_to :feed, counter_cache: true

  default_scope {order("published_at DESC")}

  scope :unread, lambda { |user, feed = nil|
    ar = all
    lr = ArticleReadLog.where(user_id: user.id)
    if feed
      ar = ar.where(feed_id: feed.id)
      lr.where(feed_id: feed.id)
    end
    readed_ids = lr.pluck(:article_id)
    return ar if readed_ids.empty?
    ar.where("id not in (?)", readed_ids)
  }
end
