class PostSerializer < ActiveModel::Serializer
  attributes :content,:image,:id
  has_many :comments
  has_many :likes
end
