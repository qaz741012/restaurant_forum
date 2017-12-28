class LikesController < ApplicationController

  def create
    like = Like.create!(restaurant_id: params[:restaurant_id], user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    like = Like.where(restaurant_id: params[:restaurant_id], user: current_user)
    like.destroy_all
    redirect_back(fallback_location: root_path)
  end

end
