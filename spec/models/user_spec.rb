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

require 'spec_helper'

describe User do
end
