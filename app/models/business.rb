class Business < ActiveRecord::Base
  PER_PAGE = 9

  extend Paginator
  include Paginator
  include Sluggable

  belongs_to :city
  belongs_to :owner, foreign_key: 'user_id', class_name: 'User'

  has_many :hours, -> { order(day: :asc) }, :dependent => :destroy
  has_many :bookmarks, :dependent => :destroy
  has_many :events, -> { order(start_time: :desc) }, :dependent => :destroy
  has_many :reviews, -> { order(created_at: :desc) }, :dependent => :destroy
  has_many :business_sub_categories, :dependent => :destroy
  has_many :sub_categories, :through => :business_sub_categories
  has_many :business_options, :dependent => :destroy
  has_many :business_pics, :dependent => :destroy

  accepts_nested_attributes_for :hours
  accepts_nested_attributes_for :business_options, allow_destroy: true

  validates :name, presence: true
  validates :address, presence: true
  validates :zip_code, presence: true, format: { with: /\A\d{5}\z/ }
  validates :price_range, presence: true
  validates :phone_number, allow_blank: true, format: { with: /\A\d{10}\z/ }

  before_validation :mark_options_for_destruction
  sluggable_column :name

  def mark_options_for_destruction
    self.business_options.each do |bo|
      if bo.option.blank?
        bo.mark_for_destruction
      end
    end
  end

  def has_images?
    self.business_pics.size > 0
  end

  def has_reviews?
    self.reviews.size > 0
  end

  def average_rating
    if self.reviews.size == 0
      0
    else
      self.reviews.map { |r| r.star_rating }.reduce(:+).to_f / self.reviews.size
    end
  end

  def open_today?
    self.hours.each do |h|
      if h.day_number == DateTime.now.wday
        return h
      end
    end

    false
  end

  def open_now?
    today = self.open_today?

    if today
      now = Time.now.strftime("%H%M")
      opens = today.opens_at.strftime("%H%M")
      closes = today.closes_at.strftime("%H%M")

      now > opens && now < closes
    else
      false
    end
  end

  def todays_hours
    today = self.open_today?

    if today
      "#{today.opens_at.strftime("%l:%M %p")} - #{today.closes_at.strftime("%l:%M %p")}"
    end
  end

  def category_icon
    if self.sub_categories.size > 0
      self.sub_categories.first.category.icon_class
    else
      "glyphicon-asterisk"
    end
  end

  def self.ranked_by_rating
    self.all.sort_by(&:average_rating).reverse
  end

  def self.ranked_by_city_rating(city)
    city.businesses.all.sort_by(&:average_rating).reverse
  end

  def upcoming_events
    Event.upcoming_events_by_business(self)
  end

  def past_events
    Event.past_events_by_business(self)
  end

  def category_options
    if self.sub_categories.size > 0
      self.sub_categories.first.category.category_options
    else
      []
    end
  end

  def has_option?(option)
    self.business_options.select do |bo|
      bo.category_option.formatted_name == option &&
      bo.option == "Yes"
    end.size > 0
  end

  def self.paginate_for_all_cities(count)
    self.paginate_array(self.ranked_by_rating, count)
  end

  def self.paginate_for_city(count, city)
    self.paginate_array(self.ranked_by_city_rating(city), count)
  end

  def paginate_upcoming_events(count)
    self.paginate_array(self.upcoming_events, count)
  end

  def paginate_reviews(count)
    self.paginate(self.reviews, count)
  end
end
