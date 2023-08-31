class UserSerializer < ActiveModel::Serializer
  attributes :fname,:lname,:email,:image
  has_many :posts
  # has_many :likes
  # has_many :comments
  # has_many :followers
  def image
    object.profile_picture.url
  end
end
