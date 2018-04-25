class EventsController < ApplicationController
  include EventMethods
  include BusinessOwnershipVerification

  before_action :require_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit, :show, :index, :city_index]
  before_action :set_count, only: [:index, :city_index]
  before_action :set_cities, only: [:index, :city_index]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_business_and_city, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :require_user_owns_business, only: [:new, :create, :edit, :update, :destroy]

  def index
    @all_events = Event.all_upcoming_events
    @pages = number_of_pages(@all_events)
    @events = Event.paginate_for_all_cities(@count)

    respond_to do |format|
      format.js
      format.html
    end
  end

  def city_index
    @city = City.find_by slug: params[:city_id]
    @all_events = Event.upcoming_events_by_city(@city)
    @pages = number_of_pages(@all_events)
    @events = Event.paginate_for_city(@count, @city)

    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @page = (params[:page] || "description")

    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @event = Event.new
  end

  def create
    values = event_params
    @event = Event.new(values)
    @event.business = @business

    if @event.save
      flash[:notice] = "Your event has been created!"
      redirect_to city_business_path(@city, @business, page: "events")
    else
      flash[:error] = "Oops, you must fill out all the fields!"
      redirect_to new_city_business_event_path(@city, @business, @event)
    end
  end

  def edit
  end

  def update
    values = event_params

    if @event.update(values)
      flash[:notice] = 'Your event was updated'
      redirect_to city_business_path(@city, @business, page: "events")
    else
      flash[:error] = "Oops, you must fill out all the fields!"
      redirect_to edit_city_business_event_path(@city, @business, @event)
    end
  end

  def destroy
    @event.destroy
    redirect_to city_business_path(@city, @business, page: "events")
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :price)
  end

  def set_business_and_city
    @business = Business.find_by slug: params[:business_id]
    @city = @business.city
  end

  def number_of_pages(list)
    (list.size / Event::PER_PAGE.to_f).ceil
  end
end
