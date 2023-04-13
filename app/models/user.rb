class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :greats, dependent: :destroy
  has_many :great_posts, through: :greats, source: :post

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # ※deviseのuserカラムに nameやprofile を追加している場合は下のコメントアウトを外して使用

      # user.name = auth.info.name
      # user.profile = auth.info.profile
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def own?(object)
    id == object.user_id
 end

  def great(post)
    great_posts <<(post)
  end

  def ungreat(post)
    great_posts.destroy(post)
  end

  def great?(post)
    great_posts.include?(post)
  end
end
