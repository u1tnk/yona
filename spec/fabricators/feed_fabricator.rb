# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  feed_url   :string(255)
#  title      :string(255)
#  html_url   :string(255)
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

Fabricator(:feed) do
  title    "MyString"
  feed_url "MyString"
  html_url "MyString"
  type     ""
end
