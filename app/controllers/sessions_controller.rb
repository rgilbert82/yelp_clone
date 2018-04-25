class SessionsController < ApplicationController
  def new
    if logged_in?
      user_is_logged_in
    end

    set_categories
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'You are signed in!'
    else
      flash[:error] = "Invalid email/password"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'You are signed out'
  end
end
