class SearchController < ApplicationController
	def search
		@search = params[:search]
		@detail = params[:detail]
		@results = results(@search, @detail)
	end

	def results(search, detail)
		if @detail.blank?
			Post.where("song LIKE? OR album LIKE? OR artist LIKE?", "%#{search}%", "%#{search}%", "%#{search}%")
		else
			if @detail == "song"
				if @search.blank?
					Post.all
				else
					Post.where("song LIKE?", "%#{search}%")
				end
			elsif @detail == "album"
				if @search.blank?
					Post.all
				else
					Post.where("album LIKE?", "%#{search}%")
				end
			elsif @detail == "artist"
				if @search.blank?
					Post.all
				else
					Post.where("artist LIKE?", "%#{search}%")
				end
			end
		end
	end
end
