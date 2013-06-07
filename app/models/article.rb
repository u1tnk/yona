# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  feed_id      :integer          not null
#  title        :string(255)      not null
#  url          :string(255)      not null
#  content      :text             not null
#  author       :string(255)
#  published_at :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Article < ActiveRecord::Base
  belongs_to :feed, counter_cache: true

  default_scope {order("published_at DESC")}
end
