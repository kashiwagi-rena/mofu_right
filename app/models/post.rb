class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :post_image
  has_many :greats, dependent: :destroy

  mount_uploader :post_image, PostImageUploader

  validates :name, presence: true, length: { maximum: 31 }
  validates :body, presence: true, length: { maximum: 31 }

  def greats_by?(user)
    greats.where(user_id: user).exists?
  end
end
