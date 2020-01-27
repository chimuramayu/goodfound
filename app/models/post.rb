class Post < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy
	attachment :post_image
end
