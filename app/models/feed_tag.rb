# == Schema Information
#
# Table name: feed_tags
#
#  id         :integer          not null, primary key
#  feed_id    :integer          not null
#  tag_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class FeedTag < ActiveRecord::Base
  belongs_to :feed
  belongs_to :tag
end
