class Conversation < ActiveRecord::Base
  belongs_to :sender, :class_name => "User", :foreign_key => :sender_id
  belongs_to :recipient, :class_name => "User", :foreign_key => :recipient_id
  has_many :messages, -> { order(created_at: :asc) }, :dependent => :destroy

  validates_presence_of :title, :sender_id, :recipient_id

  def with_whom(user)
    [self.sender, self.recipient].reject { |u| u == user }.first
  end

  def has_replies?(user)
    replies = self.messages.select do |message|
      message.user == self.recipient
    end

    user == self.recipient || replies.size > 0
  end

  def has_unread_messages?(user)
    self.messages.select do |message|
      message.unread && message.user != user
    end.size > 0
  end

  def is_in_trash?(user)
    (user == self.sender && self.sender_trash) ||
    (user == self.recipient && self.recipient_trash)
  end
end
