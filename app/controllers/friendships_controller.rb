class FriendshipsController < ApplicationController

  def create
    friendship = current_user.friendships.build(friend_id: params[:friend_id], status: "request")
    inverse_friendship = current_user.inverse_friendships.build(user_id: params[:friend_id])

    if friendship.save && inverse_friendship.save
      flash[:notice] = "successfully sent the request"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:alert] = "friendship destroyed"
    redirect_back(fallback_location: root_path)
  end

  def confirm

  end

end
