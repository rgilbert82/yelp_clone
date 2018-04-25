class ConversationsController < ApplicationController
  before_action :require_user
  before_action :set_categories, only: [:index, :show, :new]
  before_action :set_count, only: [:index]

  def index
    @page = (params[:page] || "inbox")
    @unread_conversations_count = current_user.unread_conversations_count

    case @page
    when "inbox"
      @pages = number_of_pages(current_user.untrashed_conversations)
      @conversations = current_user.paginate_untrashed_conversations(@count)
    when "sent"
      @pages = number_of_pages(current_user.untrashed_messages)
      @conversations = current_user.paginate_untrashed_messages(@count)
    when "trash"
      @pages = number_of_pages(current_user.trashed_conversations)
      @conversations = current_user.paginate_trashed_conversations(@count)
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new

    mark_conversation_as_read
  end

  def new
    @conversation = Conversation.new
    @friends = current_user.all_friends
    @to = (params[:to] || false)

    if @to
      @recipient = User.find(@to.to_i)
    end
  end

  def create
    values = conversation_params
    values[:sender_id] = current_user.id
    @conversation = Conversation.new(values.except(:message))

    if @conversation.save
      @message = Message.new(user_id: values[:sender_id], body: values[:message][:body], unread: 't', conversation_id: @conversation.id)

      if @message.save
        redirect_to conversations_path
      else
        @conversation.destroy
        flash[:error] = "The message can't be blank"
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:error] = "The subject can't be blank"
      redirect_back(fallback_location: root_path)
    end
  end

  def trash
    conversation_ids = params[:conversation_check] || []

    conversation_ids.each do |cid|
      conversation = Conversation.find(cid.to_i)
      if current_user == conversation.sender
        conversation.update_attributes(sender_trash: !conversation.sender_trash)
      elsif current_user == conversation.recipient
        conversation.update_attributes(recipient_trash: !conversation.recipient_trash)
      end
    end
    redirect_to conversations_path
  end

  private

  def conversation_params
    params.require(:conversation).permit(:title, :recipient_id, message: [:body])
  end

  def mark_conversation_as_read
    @conversation.messages.each do |message|
      if message.unread && message.user != current_user
        message.update_attributes(unread: 'f')
      end
    end
  end

  def number_of_pages(list)
    (list.size / User::MESSAGES_PER_PAGE.to_f).ceil
  end
end
