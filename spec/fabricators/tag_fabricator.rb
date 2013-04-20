# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  label      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

Fabricator(:tag) do
  label "MyString"
end
