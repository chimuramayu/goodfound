class GenresController < ApplicationController
  def show
  	@genre = Genre.find(params[:id])
  	@posts = @genre.posts.order(id: "DESC").page(params[:page]).per(20)
  	@genres = Genre.all
  end
end
