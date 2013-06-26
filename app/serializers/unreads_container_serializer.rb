class UnreadsContainerSerializer < ActiveModel::Serializer
  has_one :tag
  has_many :user_feeds
end
