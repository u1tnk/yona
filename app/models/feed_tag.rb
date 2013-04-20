# == Schema Information
#
# Table name: feed_tags
#
#  id         :integer          not null, primary key
#  feed_id    :integer
#  tag_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class FeedTag < ActiveRecord::Base
  belongs_to :feed
  belongs_to :tag
end
