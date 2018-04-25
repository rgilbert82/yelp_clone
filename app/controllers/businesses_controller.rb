class BusinessesController < ApplicationController
  include BusinessOwnershipVerification

  before_action :set_categories, only: [:new, :edit, :show, :index, :city_index, :details]
  before_action :set_cities, only: [:index, :city_index]
  before_action :set_count, only: [:index, :city_index, :show]
  before_action :set_business_and_city, only: [:show, :edit, :update, :destroy, :details, :write_details]
  before_action :require_user, only: [:new, :create, :edit, :update, :destroy, :details, :write_details]
  before_action :require_user_owns_business, only: [:edit, :update, :details, :write_details, :destroy]

  helper_method :set_business_option

  def index
    @pages = number_of_pages(Business.all)
    @businesses = Business.paginate_for_all_cities(@count)
    @reviews = Review.order(created_at: :desc).limit(6)

    if params[:page] == "write-review"
      flash[:notice] = "Pick a business to review!"
      redirect_to root_path
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def city_index
    @city = City.find_by slug: params[:city_id]
    @pages = number_of_pages(@city.businesses.all)
    @businesses = Business.paginate_for_city(@count, @city)
    @reviews = Review.select { |r| r.business.city == @city }.slice(0, 6).reverse

    if params[:page] == "write-review"
      flash[:notice] = "Pick a business to review!"
      redirect_to city_businesses_path(@city)
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @page = (params[:page] || "reviews")
    @upcoming_events = @business.paginate_upcoming_events(@count) || []

    case @page
    when "reviews"
      @pages = number_of_pages(@business.reviews)
      @reviews = @business.paginate_reviews(@count)
    when"events"
      @pages = number_of_pages(@business.upcoming_events)
      @past_events = @business.past_events.take(10)
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @business = Business.new
    set_week
  end

  def create
    business_values = business_params.except(:hours_attributes)
    @hours = get_hours
    @business = Business.new(business_values)
    @business.user_id = current_user.id

    if @business.save
      write_business_hours
      flash[:notice] = "Your business page was created!"
      redirect_to details_city_business_path(@business.city, @business)
    else
      flash[:error] = "Oops, you must fill out all the fields!"
      redirect_to new_city_business_path(current_user.city)
    end
  end

  def edit
    set_week
  end

  def update
    business_values = business_params.except(:hours_attributes)
    @hours = get_hours

    if @business.update(business_values)
      write_business_hours
      flash[:notice] = 'Your business was updated'
      redirect_to details_city_business_path(@city, @business)
    else
      flash[:error] = "Oops, you must fill out all the fields!"
      redirect_to edit_city_business_path(@business.city, @business)
    end
  end

  def details
    @category_options = CategoryOption.all

    if @business.sub_categories.size == 0
      flash[:error] = "Please select a category for your business."
      redirect_to edit_city_business_path(@business.city, @business)
    end
  end

  def write_details
    if @business.update(business_option_params)
      redirect_to city_business_path(@city, @business)
    else
      flash[:error] = "Oops, something went wrong!"
      redirect_to details_city_business_path(@city, @business)
    end
  end

  def destroy
    if current_user.owns_business?(@business)
      @business.destroy
      redirect_to user_path(current_user, page: "businesses")
    else  # for admins
      @business.destroy
      redirect_to root_path
    end
  end

  private

  def business_params
    params.require(:business).permit(:name, :phone_number, :address, :zip_code,
      :city_id, :price_range, :sub_category_ids => [],
      hours_attributes: [:day, :opens_at, :closes_at])
  end

  def business_option_params
    params.require(:business).permit(business_options_attributes: [:option,
      :category_option_id, :id, :_destroy])
  end

  def get_hours
    business_params[:hours_attributes].reject! do |k, v|
      v["opens_at(4i)"].blank? || v["closes_at(4i)"].blank?
    end
  end

  def write_business_hours
    @business.hours.destroy_all
    @hours.each { |k, v| v[:business_id] = @business.id }.each do |k, v|
      Hour.create(v)
    end
  end

  def set_week
    @week = []

    if @business.new_record?
      1.upto(7).each { |n| @week << Hour.new(day: n) }
    else
      @business.hours.each { |h| @week << h }

      1.upto(7) do |n|
        if @week.select { |h| h.day == n.to_s }.size == 0
          @week << Hour.new(day: n)
        end
      end
    end

    @week = @week.sort_by { |h| h.day }
  end

  def set_business_and_city
    @business = Business.find_by slug: params[:id]
    @city = @business.city
  end

  def number_of_pages(list)
    (list.size / Business::PER_PAGE.to_f).ceil
  end

  def set_business_option(category_option)
    existing_options = @business.business_options.where(category_option: category_option)

    if existing_options.empty?
      BusinessOption.new(business: @business, category_option: category_option)
    else
      existing_options.first
    end
  end
end
