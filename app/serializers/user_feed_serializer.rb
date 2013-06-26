class UserFeedSerializer < ActiveModel::Serializer
  attributes :id, :unread_articles_count
  has_one :feed
end
