class City < ActiveRecord::Base
  include Sluggable

  has_many :users, :dependent => :destroy
  has_many :businesses, :dependent => :destroy
  has_many :topics, :dependent => :destroy
  belongs_to :state

  validates :name, presence: true

  sluggable_column :name

  def format_city_state
    "#{self.name}, #{self.state.name}"
  end
end
