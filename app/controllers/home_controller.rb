class HomeController < ApplicationController
	def home
	end

	def list
		@genres = Genre.all
	end

	def about
	end
end
