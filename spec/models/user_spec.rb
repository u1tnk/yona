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
  let(:user){Fabricate :user}
  let(:feed){Fabricate :feed}

  describe '#read' do
    it '既読履歴が残る' do
      now = DateTime.now
      Timecop.freeze(now) do
        user.read(feed.articles.first)
        expect(user.user_articles.size).to eq 1
        expect(user.user_articles.first.readed_at).to eq now
      end
    end
  end

end
