module InteractWithOtherUser
  def set_other_user
    @other_user = User.find_by slug: params[:id]
  end
end
