class SubCategory < ActiveRecord::Base
  include CategorySorting
  include Sluggable

  belongs_to :category
  has_many :business_sub_categories, :dependent => :destroy
  has_many :businesses, :through => :business_sub_categories

  validates :name, presence: true

  sluggable_column :name

  def all_businesses
    self.businesses.sort_by { |b| b.average_rating }.reverse
  end

  def city_businesses(city)
    self.businesses.select { |b| b.city == city }.
                    sort_by { |b| b.average_rating }.reverse
  end
end
