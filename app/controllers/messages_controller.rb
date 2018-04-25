class MessagesController < ApplicationController
  before_action :require_user
  before_action :require_user_owns_conversation

  def create
    conversation = Conversation.find(params[:conversation_id])
    values = message_params
    values[:conversation_id] = conversation.id
    values[:user_id] = current_user.id
    values[:unread] = 't'
    @message = Message.new(values)

    if @message.save
      flash[:notice] = "Your message was sent!"
    else
      flash[:error] = "The message can't be blank"
    end
    redirect_to conversation_path(conversation)
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
  
  def require_user_owns_conversation
    conversation = Conversation.find(params[:conversation_id])
    current_user == conversation.sender || current_user == conversation.recipient
  end
end
