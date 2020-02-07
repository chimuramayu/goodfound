class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :following, :followers, :favorites]

  def show
  	@favorites = @user.favorites
    @following = @user.followings
    @followers = @user.followers
  	@posts = @user.posts.order(created_at: "DESC").page(params[:page]).per(6)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
  end

  def following
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end

  def favorites
    @posts = @user.favorite_posts.order(id: "DESC")
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile, :icon_image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
