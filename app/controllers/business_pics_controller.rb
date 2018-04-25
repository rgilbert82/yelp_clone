class BusinessPicsController < ApplicationController
  before_action :require_user, only: [:create]
  before_action :set_categories, only: [:index, :user_index]
  before_action :set_business_and_city, only: [:index, :show, :create]

  helper_method :next_photo, :prev_photo

  def index
    @business_pic = BusinessPic.new
    @photo_id = params[:photo]
  end

  def user_index
    @user = User.find_by slug: params[:id]
  end

  def create
    business_pic = BusinessPic.new(business_pic_params)
    business_pic.business = @business
    business_pic.user = current_user

    if business_pic.save
      flash[:notice] = "Thanks for submitting your picture"
    else
      flash[:error] = "Oops, something went wrong with your upload!"
    end
    redirect_back(fallback_location: root_path)
  end

  def show
    @photo = BusinessPic.find(params[:id])
    @user = User.where(id: params[:user_id]).first

    respond_to do |format|
      format.js
    end
  end

  private

  def business_pic_params
    params.require(:business_pic).permit(:image)
  end

  def set_business_and_city
    @business = Business.find_by slug: params[:business_id]
    @city = @business.city
  end

  def next_photo(photo, user)
    if user
      photos = BusinessPic.where(user: user)
    else
      photos = BusinessPic.where(business: photo.business)
    end

    index = photos.index(photo)

    if photo == photos.last
      photos.first
    else
      photos[index + 1]
    end
  end

  def prev_photo(photo, user)
    if user
      photos = BusinessPic.where(user: user)
    else
      photos = BusinessPic.where(business: photo.business)
    end

    index = photos.index(photo)

    if photo == photos.first
      photos.last
    else
      photos[index - 1]
    end
  end
end
