class FeedSerializer < ActiveModel::Serializer
  attributes :id, :title, :html_url, :url
end
