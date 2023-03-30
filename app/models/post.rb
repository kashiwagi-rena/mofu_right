class Post < ApplicationRecord
  #belongs_to :user

  validates :name, presence: true, length: { maximum: 31 }
  validates :body, presence: true, length: { maximum: 31 }
end
