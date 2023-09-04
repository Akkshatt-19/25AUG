class UserSerializer < ActiveModel::Serializer
  attributes :id, :fname, :lname, :email, :image, :created_at, :updated_at

  has_many :posts

  def image
    object.profile_picture.url
  end
end
