class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :set_cities, :upcoming_events,
                :past_events, :current_user_is_admin?

  def require_user
    redirect_to login_path unless current_user
  end

  def current_user
    if session[:user_id] && User.exists?(session[:user_id])
      @current_user ||= User.find(session[:user_id])
    end
  end

  def current_user_is_admin?
    logged_in? && current_user.admin?
  end

  def set_user
    @user = current_user
  end

  def logged_in?
    !!current_user
  end

  def user_is_logged_in
    flash[:notice] = "You are logged in"
    redirect_to root_path
  end

  def set_cities
    @cities = State.order(:name).map {|s| s.cities }.flatten
  end

  def set_categories
    @categories = Category.all
  end

  def set_count
    @count = (params[:count] || 1).to_i
  end

  def upcoming_events(events)
    events.select do |event|
      event.start_time > DateTime.now
    end.sort_by { |e| e.start_time }
  end

  def past_events(events)
    events.select do |event|
      event.start_time < DateTime.now
    end.sort_by { |e| e.start_time }
  end
end
