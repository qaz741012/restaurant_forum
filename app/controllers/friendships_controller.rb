class FriendshipsController < ApplicationController

  def create
    friendship = current_user.friendships.build(friend_id: params[:friend_id], status: "request")
    inverse_friendship = current_user.inverse_friendships.build(user_id: params[:friend_id], status: "unconfirm")

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
    inverse_friendship = current_user.inverse_friendships.where(user_id: params[:id]).first

    friendship.destroy
    inverse_friendship.destroy
    flash[:alert] = "successfully cancel the request"
    redirect_back(fallback_location: root_path)
  end

  def confirm
    friendship = current_user.friendships.find_by(friend_id: params[:friend_id])
    inverse_friendship = current_user.inverse_friendships.find_by(user_id: params[:friend_id])

    if friendship.update(status: "confirm") && inverse_friendship.update(status: "confirm")
      flash[:notice] = "successfully add #{User.find(params[:friend_id]).name} to friend"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

end
