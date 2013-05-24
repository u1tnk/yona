# == Schema Information
#
# Table name: user_articles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  article_id :integer          not null
#  readed     :boolean          default(FALSE), not null
#  created_at :datetime
#  updated_at :datetime
#

class UserArticle < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
end
