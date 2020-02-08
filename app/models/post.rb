class Post < ApplicationRecord
	# アソシエーション
	belongs_to :user
	belongs_to :genre
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	def favorited_by?(user)
		favorites.find_by(user_id: user.id).present?
	end
	attachment :post_image

	validates :song_or_album, presence: true
	validates :artist, presence: true
	validates :body, length: {maximum: 400}

	private
		def song_or_album
			song.presence or album.presence
		end
end
