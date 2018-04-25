module BusinessOwnershipVerification
  def require_user_owns_business
    unless current_user_is_admin? || current_user.owns_business?(@business)
      flash[:error] = "You can't do that"
      redirect_to root_path
    end
  end
end
