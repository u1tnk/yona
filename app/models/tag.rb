# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  label      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  belongs_to :user
  has_many :feed_tags
  has_many :feeds, through: :feed_tags

  default_scope {order(:label)}
end
