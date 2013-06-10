# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  feed_id      :integer          not null
#  title        :string(255)      not null
#  url          :string(255)      not null
#  content      :text(16777215)
#  author       :string(255)
#  published_at :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

Fabricator(:article) do
  title    "MyString"
  url  {Faker::Internet.http_url}
  feed {Fabricate.build :feed}
  content {Faker::Lorem.paragraph}
end
