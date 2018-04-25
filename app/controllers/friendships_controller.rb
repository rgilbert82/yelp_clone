class FriendshipsController < ApplicationController
  include InteractWithOtherUser

  before_action :require_user
  before_action :set_other_user

  def status
    if current_user.friends.exists?(@other_user.id)
      unfriend(current_user.id, @other_user.id)
    elsif current_user.inverse_friends.exists?(@other_user.id)
      unfriend(@other_user.id, current_user.id)
    else
      Friendship.create(user_id: current_user.id, friend_id: @other_user.id)
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def unfriend(user_id, friend_id)
    fr = Friendship.where(user_id: user_id, friend_id: friend_id).first
    Friendship.delete(fr.id)
  end
end
