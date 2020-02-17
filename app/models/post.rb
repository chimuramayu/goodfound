class Post < ApplicationRecord
	# アソシエーション
	belongs_to :user
	belongs_to :genre
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :favorite_users, through: :favorites, source: :user

	attachment :post_image

	validates :song_or_album, presence: true
	validates :artist, presence: true
	validates :body, length: {maximum: 400}

	def favorited_by?(user)
		favorites.find_by(user_id: user.id).present?
	end

	private
		def song_or_album
			song.presence or album.presence
		end
end
