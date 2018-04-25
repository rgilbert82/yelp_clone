class Category < ActiveRecord::Base
  include CategorySorting
  include Sluggable

  has_many :sub_categories, -> { order(name: :asc) }, :dependent => :destroy
  has_many :category_options, :dependent => :destroy
  validates :name, presence: true

  sluggable_column :name

  def all_businesses
    self.sub_categories.map do |sc|
      sc.businesses
    end.flatten.uniq.sort_by { |b| b.average_rating }.reverse
  end

  def city_businesses(city)
    self.all_businesses.select { |b| b.city == city }
  end
end
