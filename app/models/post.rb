class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :post_image
  #dependent: :destroy = 親モデルを削除する際に、その親モデルに紐づく「子モデル」も一緒に削除できる
  has_many :comments, dependent: :destroy
  has_many :greats, dependent: :destroy

  mount_uploader :post_image, PostImageUploader

  validates :name, presence: true, length: { maximum: 31 }
  validates :body, presence: true, length: { maximum: 31 }

  def greats_by?(user)
    greats.where(user_id: user).exists?
  end
end
