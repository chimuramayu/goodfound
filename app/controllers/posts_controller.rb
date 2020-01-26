class PostsController < ApplicationController
  def index
    @posts = Post.all.order(id: "DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to timeline_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:song, :album, :artist, :body, :post_image, :user_id)
  end
end
