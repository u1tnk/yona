class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :content, :url
end
