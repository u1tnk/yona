
require 'spec_helper'

describe UserFeed do
  let(:user){Fabricate :user}
  let(:other_user){Fabricate :user}
  let(:feed){Fabricate(:article).feed}

  describe '.unreads' do
    before do
      UserFeed.create feed: feed, user: user
      3.times do
        Fabricate :article, feed: feed
      end

      # 別のfeed
      UserFeed.create feed: Fabricate(:article).feed, user: user
      # feed共有する別のユーザのfeed
      UserFeed.create feed: feed, user: other_user
    end

    subject {UserFeed.unreads(user).count}

    context '既読無し' do
      it {should be 2}
    end

    context '既読有り' do
      context 'feed1が一部未読' do
        before do
          user.read(Article.where(feed: feed).first)
        end
        it {should be 2}
      end
      context 'feed1が全件既読' do
        before do
          Article.where(feed: feed).each do |a|
            user.read(a)
          end
        end
        it {should be 1}
      end
    end
  end
end

