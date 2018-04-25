class ReviewsController < ApplicationController
  include ReviewMethods

  before_action :set_categories, only: [:new, :create, :edit, :update]
  before_action :require_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_business, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :require_user_has_review_privileges, only: [:edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    values = review_params
    values[:star_rating] = values[:star_rating].to_i
    @review = Review.new(values)
    @review.user = current_user
    @review.business = @business

    if @review.save
      flash[:notice] = "Thanks for reviewing!"
      redirect_to city_business_path(@business.city, @business)
    else
      flash[:error] = "You must select a Star Rating and write a review!"
      redirect_to new_city_business_review_path(@business.city, @business, @review)
    end
  end

  def edit
  end

  def update
    values = review_params
    values[:star_rating] = values[:star_rating].to_i

    if @review.update(values)
      flash[:notice] = 'Your review was updated'
      redirect_to city_business_path(@business.city, @business)
    else
      flash[:error] = "You can't post an empty review!"
      redirect_to edit_city_business_review_path(@business.city, @business, @review)
    end
  end

  def destroy
    @review.destroy
    redirect_to city_business_path(@business.city, @business)
  end

  private

  def review_params
    params.require(:review).permit(:star_rating, :body)
  end

  def require_user_has_review_privileges
    unless current_user_is_admin? || current_user.reviews.include?(Review.find(params[:id]))
      flash[:error] = "You can't do that"
      redirect_to root_path
    end
  end

  def set_business
    @business = Business.find_by slug: params[:business_id]
  end
end
