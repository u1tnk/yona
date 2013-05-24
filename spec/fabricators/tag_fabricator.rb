# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  label      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

Fabricator(:tag) do
  label "MyString"
end
