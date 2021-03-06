# == Schema Information
#
# Table name: feeds
#
#  id               :integer          not null, primary key
#  url              :string(255)      not null
#  title            :string(255)      not null
#  html_url         :string(255)      not null
#  kind             :string(255)      not null
#  creator          :string(255)
#  etag             :string(255)
#  last_modified_at :datetime
#  articles_count   :integer          default(0), not null
#  created_at       :datetime
#  updated_at       :datetime
#

Fabricator(:feed) do
  title    "MyString"
  url {Faker::Internet.http_url}
  html_url {Faker::Internet.http_url}
  kind     :rss
end
