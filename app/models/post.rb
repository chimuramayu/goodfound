class Post < ApplicationRecord
	# アソシエーション
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	def favorited_by?(user)
		favorites.find_by(user_id: user.id).present?
	end
	attachment :post_image
end
