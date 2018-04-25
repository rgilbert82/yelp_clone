class UsersController < ApplicationController
  before_action :set_categories, only: [:index, :city_index, :show, :new, :create, :edit]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :set_cities, only: [:index, :city_index]
  before_action :set_city, only: [:city_index]
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :set_users, only: [:index, :city_index]

  def index
  end

  def city_index
  end

  def show
    @user = User.find_by slug: params[:id]
    @count = (params[:count] || 1).to_i
    @page = (params[:page] || "overview")

    case @page
    when "reviews"
      @pages = number_of_pages(@user.reviews)
      @list = @user.paginate_reviews(@count)
    when "feed"
      @pages = number_of_pages(@user.following_reviews)
      @list = @user.paginate_following_reviews(@count)
    when "businesses"
      @pages = number_of_pages(@user.businesses)
      @list = @user.paginate_businesses(@count)
    when "bookmarks"
      @pages = number_of_pages(@user.bookmarks)
      @list = @user.paginate_bookmarks(@count)
    when "events"
      @pages = number_of_pages(upcoming_events(@user.events))
      @upcoming_events = Event.upcoming_events_by_user(@user)
      @past_events = Event.past_events_by_user(@user)
      @list = @user.paginate_array(@upcoming_events, @count)
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @user = User.new
  end

  def create
    values = user_params
    @user = User.new(values)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You are now registered"
      redirect_to root_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
  end

  def update
    values = user_params

    if @user.update(values)
      flash[:notice] = 'Your profile was updated!'
      redirect_to user_path(@user)
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_to edit_user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :city_id, :avatar, :tagline,
      :gender, :i_love, :hometown, :website, :when_im_not_reviewing)
  end

  def set_city
    @city = City.find_by slug: params[:city_id]
  end

  def set_users
    @users = User.select { |u| u != current_user }.sort_by { |u| u.name }

    if @city
      @users = @users.select { |u| u.city == @city }
    end
  end

  def number_of_pages(list)
    (list.size / User::PER_PAGE.to_f).ceil
  end
end
