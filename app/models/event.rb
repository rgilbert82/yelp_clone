class Event < ActiveRecord::Base
  PER_PAGE = 10

  extend Paginator
  include Sluggable

  belongs_to :business
  has_many :user_events, :dependent => :destroy
  has_many :users, :through => :user_events, :dependent => :destroy

  validates_presence_of :name, :price, :description
  sluggable_column :name


  def self.all_upcoming_events
    self.select do |event|
      event.start_time > DateTime.now
    end.sort_by { |e| e.start_time }
  end

  def self.upcoming_events(events)
    events.select do |event|
      event.start_time > DateTime.now
    end.sort_by { |e| e.start_time }
  end

  def self.past_events(events)
    events.select do |event|
      event.start_time < DateTime.now
    end.sort_by { |e| e.start_time }
  end

  def self.upcoming_events_by_city(city)
    self.upcoming_events(Event.all.select { |e| e.business.city == city })
  end

  def self.upcoming_events_by_user(user)
    self.upcoming_events(user.events)
  end

  def self.past_events_by_user(user)
    self.past_events(user.events)
  end

  def self.upcoming_events_by_business(business)
    self.upcoming_events(business.events)
  end

  def self.past_events_by_business(business)
    self.past_events(business.events)
  end

  def self.paginate_for_all_cities(count)
    self.paginate_array(self.all_upcoming_events, count)
  end

  def self.paginate_for_city(count, city)
    self.paginate_array(self.upcoming_events_by_city(city), count)
  end
end
