require 'spec_helper'

describe Article do
  let(:user){Fabricate :user}
  let(:other_user){Fabricate :user}
  let(:feed){Fabricate(:article).feed}

  describe '.unread' do
    before do
      UserFeed.create feed: feed, user: user
      3.times do
        Fabricate :article, feed: feed
      end

      # 別のfeed
      UserFeed.create feed: Fabricate(:article).feed, user: user
      # feed共有する別のfeed
      UserFeed.create feed: feed, user: other_user
    end

    context '既読無し' do
      context '全件' do
        it {expect(Article.unread(user).count).to be 5}
      end
      context 'feed指定' do
        it {expect(Article.unread(user, feed).count).to be 4}
      end
    end

    context '既読有り' do
      before do
        user.read(Article.where(feed: feed).first)
      end
      context '全件' do
        it {expect(Article.unread(user).count).to be 4}
      end
      context 'feed指定' do
        it {expect(Article.unread(user, feed).count).to be 3}
      end
    end
  end
end
