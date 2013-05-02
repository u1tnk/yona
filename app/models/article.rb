# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  feed_id      :integer
#  title        :string(255)
#  url          :string(255)
#  content      :text
#  author       :string(255)
#  published_at :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Article < ActiveRecord::Base
  belongs_to :feed

  default_scope {order("published_at DESC")}

end
