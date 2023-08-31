class UserSerializer < ActiveModel::Serializer
  attributes :fname,:lname,:email
  has_many :posts
  has_many :likes
  has_many :comments
end
