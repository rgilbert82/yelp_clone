class FollowingsController < ApplicationController
  include InteractWithOtherUser

  before_action :require_user
  before_action :set_other_user

  def status
    if current_user.followings.exists?(@other_user.id)
      fl = Follow.where(user_id: current_user.id, following_id: @other_user.id).first
      Follow.delete(fl.id)
    else
      Follow.create(user_id: current_user.id, following_id: @other_user.id)
    end

    respond_to do |format|
      format.js
    end
  end
end
