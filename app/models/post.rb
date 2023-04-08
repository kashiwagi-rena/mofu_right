class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :post_image
  mount_uploader :post_image, PostImageUploader

  validates :name, presence: true, length: { maximum: 31 }
  validates :body, presence: true, length: { maximum: 31 }
end
