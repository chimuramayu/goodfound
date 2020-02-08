class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :validatable
	# アソシエーション
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :favorite_posts, through: :favorites, source: :post
	has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
	has_many :followings, through: :active_relationships, source: :follower
	has_many :passive_relationships, class_name:  "Relationship", foreign_key: :follower_id, dependent: :destroy
	has_many :followers, through: :passive_relationships, source: :following

	attachment :icon_image

	validates :username, uniqueness: true, length: {in: 6..20}, format: { with: /\A[a-zA-Z0-9_]+\z/,
    message: "は半角英数字と_のみが使えます" }
	validates :name, length: {maximum: 20}
	validates :profile, length: {maximum: 200}

	def followed_by?(user)
		passive_relationships.find_by(following_id: user.id).present?
	end
end
