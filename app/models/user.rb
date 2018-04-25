class User < ActiveRecord::Base
  PER_PAGE = 5
  MESSAGES_PER_PAGE = 20

  include Paginator
  include Sluggable

  belongs_to :city

  has_many :reviews, -> { order(created_at: :desc) }, :dependent => :destroy
  has_many :bookmarks, -> { order(created_at: :desc) }, :dependent => :destroy
  has_many :topics, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :businesses, :dependent => :destroy
  has_many :review_stats, :dependent => :destroy
  has_many :business_pics, :dependent => :destroy

  has_many :user_events, :dependent => :destroy
  has_many :events, :through => :user_events

  has_many :conversations, :foreign_key => :sender_id, :dependent => :destroy
  has_many :received_conversations, :class_name => "Conversation", :foreign_key => :recipient_id, :dependent => :destroy
  has_many :messages, :dependent => :destroy

  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => :friend_id
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :follows, :dependent => :destroy
  has_many :followings, :through => :follows
  has_many :inverse_follows, :class_name => "Follow", :foreign_key => :following_id, :dependent => :destroy
  has_many :followers, :through => :inverse_follows, :source => :user

  validates_presence_of :name
  validates_presence_of :password
  validates_presence_of :email
  validates_uniqueness_of :email

  has_secure_password validations: false

  mount_uploader :avatar, ImageUploader

  sluggable_column :name
  before_create :generate_token

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

  def count_review_stars(n)
    self.reviews.select do |review|
      review.star_rating == n
    end.size
  end

  def has_images?
    self.business_pics.size > 0
  end

  def all_friends
    [self.friends, self.inverse_friends].flatten.sort_by { |f| f.name }
  end

  def all_conversations
    [self.conversations, self.received_conversations].flatten
  end

  def untrashed_conversations
    self.all_conversations.reject do |conversation|
      (conversation.sender == self && conversation.sender_trash) ||
      (conversation.recipient == self && conversation.recipient_trash) ||
      !conversation.has_replies?(self)
    end.sort_by do |c|
      c.messages.last.created_at
    end.reverse
  end

  def trashed_conversations
    self.all_conversations.select do |conversation|
      (conversation.sender == self && conversation.sender_trash) ||
      (conversation.recipient == self && conversation.recipient_trash)
    end.sort_by do |c|
      c.messages.last.created_at
    end.reverse
  end

  def unread_conversations_count
    self.untrashed_conversations.select do |c|
      c.has_unread_messages?(self)
    end.size
  end

  def untrashed_messages
    self.messages.reject do |message|
      (message.conversation.sender == self && message.conversation.sender_trash) ||
      (message.conversation.recipient == self && message.conversation.recipient_trash)
    end
  end

  def has_bookmark?(business)
    !Bookmark.where(user: self, business: business).empty?
  end

  def is_attending?(event)
    self.events.include?(event)
  end

  def owns_business?(business)
    self.businesses.exists?(business.id)
  end

  def owns_event?(event)
    self.businesses.exists?(event.business.id)
  end

  def useful_count
    self.review_stats.select { |rs| rs.useful }.count
  end

  def funny_count
    self.review_stats.select { |rs| rs.funny }.count
  end

  def cool_count
    self.review_stats.select { |rs| rs.cool }.count
  end

  def following_reviews
    self.followings.map { |f| f.reviews }.flatten.sort_by do |r|
      r.created_at
    end.reverse
  end

  def paginate_messages_array(arr, count)
    arr.slice((count - 1) * MESSAGES_PER_PAGE, MESSAGES_PER_PAGE)
  end

  def paginate_businesses(count)
    self.paginate(self.businesses, count)
  end

  def paginate_reviews(count)
    self.paginate(self.reviews, count)
  end

  def paginate_bookmarks(count)
    self.paginate(self.bookmarks, count)
  end

  def paginate_following_reviews(count)
    self.paginate_array(self.following_reviews, count)
  end

  def paginate_untrashed_messages(count)
    self.paginate_messages_array(self.untrashed_messages, count)
  end

  def paginate_untrashed_conversations(count)
    self.paginate_messages_array(self.untrashed_conversations, count)
  end

  def paginate_trashed_conversations(count)
    self.paginate_messages_array(self.trashed_conversations, count)
  end
end
