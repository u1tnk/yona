# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  provider    :string(255)
#  uid         :string(255)
#  name        :string(255)
#  screen_name :string(255)
#  image       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

Fabricator(:user) do
  provider "MyString"
  uid "MyString"
  name "MyString"
  screen_name "MyString"
end
