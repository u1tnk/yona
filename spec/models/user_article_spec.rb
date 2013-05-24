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

require 'spec_helper'

describe UserArticle do
  pending "add some examples to (or delete) #{__FILE__}"
end
