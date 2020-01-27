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
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
    @favorites = @post.favorites
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to timeline_path
    else
      render 'update'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to timeline_path
  end

  private
  def post_params
    params.require(:post).permit(:song, :album, :artist, :body, :post_image, :user_id)
  end
end
