class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :following, :followers, :favorites]
  before_action :ensure_collect_user, only: [:edit, :update]

  def show
  	@posts = @user.posts.order(id: "DESC").page(params[:page]).per(20)
    @post_count = @user.posts
  end

  def edit
  end

  def update
    if params[:delete_image]
      @user.icon_image = nil
      @user.save
      render 'edit'
      return
    end

    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
  end

  def following
    @following = @user.followings.order(id: "DESC").page(params[:page]).per(20)
  end

  def followers
    @followers = @user.followers.order(id: "DESC").page(params[:page]).per(20)
  end

  def favorites
    @favorites = @user.favorite_posts.order(id: "DESC").page(params[:page]).per(20)
  end

  private
  def user_params
    params.require(:user).permit(:username, :name, :profile, :icon_image)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_collect_user
    if current_user.id != @user.id
      redirect_to timeline_path
    end
  end
end
