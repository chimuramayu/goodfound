class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@favorites = @user.favorites
    @following = @user.followings
    @followers = @user.followers
  	@posts = @user.posts.order(id: "DESC")
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
  end

  def following
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def favorites
    user = User.find(params[:id])
    @posts = user.favorite_posts.order(id: "DESC")
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile, :icon_image)
  end
end
