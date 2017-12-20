class UsersController < ApplicationController
  before_action :set_user

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

  private

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
