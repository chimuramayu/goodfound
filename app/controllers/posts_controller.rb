class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :ensure_collect_user, only: [:edit, :update, :destroy]

  def index
    followings = current_user.followings
    # タイムラインにログインしているユーザーを追加
    timeline_users = [current_user]
    # タイムラインにフォローしているユーザーを1人ずつ追加
    followings.each do |following|
      timeline_users << following
    end
    @posts = Post.where(user_id: timeline_users).order(id: "DESC").page(params[:page]).per(10)
    @genres = Genre.all
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
    @comment = Comment.new
    @comments = @post.comments
    @favorites = @post.favorites
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to timeline_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to timeline_path
  end

  private
  def post_params
    params.require(:post).permit(:song, :album, :artist, :body, :post_image, :url, :user_id, :genre_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def ensure_collect_user
    if current_user.id != @post.user_id
      redirect_to timeline_path(@user)
    end
  end
end
