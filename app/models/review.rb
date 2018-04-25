class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :business
  has_many :review_stats, :dependent => :destroy

  validates_presence_of :body
  validates_numericality_of :star_rating,
    :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5

  def useful_count
    count = self.review_stats.select { |rs| rs.useful }.count
    count > 0 ? count : ''
  end

  def funny_count
    count = self.review_stats.select { |rs| rs.funny }.count
    count > 0 ? count : ''
  end

  def cool_count
    count = self.review_stats.select { |rs| rs.cool }.count
    count > 0 ? count : ''
  end

  def abbreviated
    if self.body.size > 100
      self.body[0..100] + '...'
    else
      self.body
    end
  end

  def user_voted_useful?(user)
    self.review_stats.select do |rs|
      rs.user == user && rs.useful
    end.size > 0
  end

  def user_voted_funny?(user)
    self.review_stats.select do |rs|
      rs.user == user && rs.funny
    end.size > 0
  end

  def user_voted_cool?(user)
    self.review_stats.select do |rs|
      rs.user == user && rs.cool
    end.size > 0
  end
end
