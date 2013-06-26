class UnreadsContainer
  include ActiveModel::SerializerSupport
#   include ActiveModel::ArraySerializationSupport

  attr_accessor :tag, :user_feeds
end
