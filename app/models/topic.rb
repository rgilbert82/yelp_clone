class Topic < ActiveRecord::Base
  PER_PAGE = 20

  extend Paginator
  include Sluggable

  belongs_to :topic_category
  belongs_to :user
  belongs_to :city
  has_many :posts, :dependent => :destroy

  validates_presence_of :title
  sluggable_column :title

  def self.user_city_topics(user, city)
    user_topics = user.posts.map {|p| p.topic }.uniq

    self.city_topics(city).select do |topic|
      user_topics.include?(topic)
    end
  end

  def self.city_topics(city)
    self.where(city: city).sort_by { |t| t.posts.last.created_at }.reverse
  end

  def self.city_category_topics(city, category_id)
    self.where(city_id: city.id, topic_category_id: category_id)
  end

  def self.paginate_city_topics(city, count)
    self.paginate_array(self.city_topics(city), count)
  end

  def self.paginate_user_city_topics(user, city, count)
    self.paginate_array(self.user_city_topics(user, city), count)
  end

  def self.paginate_city_category_topics(city, category_id, count)
    self.paginate(self.city_category_topics(city, category_id), count)
  end
end
