class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :updated_at

  belongs_to :user
  has_many :comments
  has_many :likes

  def image
    object.image.url
  end
end
