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

Fabricator(:article) do
  title    "MyString"
  url  { sequence(:url).to_s }
  content "MyString"
end
