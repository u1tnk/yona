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

Fabricator(:feed_tag) do
  feed nil
  tag  nil
end
