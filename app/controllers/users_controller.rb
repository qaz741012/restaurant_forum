class UsersController < ApplicationController
  before_action :set_user, except: [:index]

  def index
    @users = User.all
  end

  def show
    @commented_restaurants = @user.restaurants.uniq
    @favorited_restaurants = @user.favorited_restaurants
  end

  def edit
    if current_user != @user
      flash[:alert] = "You are not allow to edit the profile"
      redirect_to user_path(@user)
    end

  end

  def update
    @user.update(user_params)
    flash[:notice] = "user profile was successfully updated"
    redirect_to user_path(@user)
  end

  def friend_list
    @unconfirm_friends = @user.unconfirm_friends
    @request_friends = @user.request_friends
  end

  private

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
