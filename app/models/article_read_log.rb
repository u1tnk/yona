# == Schema Information
#
# Table name: article_read_logs
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  article_id :integer          not null
#  readed_at  :datetime
#  created_at :datetime
#  updated_at :datetime
#

class ArticleReadLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  belongs_to :feed
end
