class Admin::UsersController < Admin::AdminsController
  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_back(fallback_location: users_path)
  end
end
