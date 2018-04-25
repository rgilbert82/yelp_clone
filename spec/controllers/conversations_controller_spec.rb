require 'spec_helper'

describe ConversationsController do
  describe "GET new" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }
    let(:bob) { Fabricate(:user, city: la) }

    it "sets @conversation if logged in" do
      session[:user_id] = alice.id
      get :new
      expect(assigns(:conversation)).to be_instance_of(Conversation)
    end

    it "sets @friends if logged in" do
      Friendship.create(user_id: alice.id, friend_id: bob.id)
      session[:user_id] = alice.id
      get :new
      expect(assigns(:friends)).to include(bob)
    end

    it "sets @recipient if @to params exists" do
      session[:user_id] = alice.id
      get :new, to: bob.id
      expect(assigns(:recipient)).to eq(bob)
    end

    it "redirects to the login path for unauthenticated users" do
      get :new
      expect(response).to redirect_to login_path
    end
  end

  describe "POST create" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }
    let(:bob) { Fabricate(:user, city: la) }
    before { request.env["HTTP_REFERER"] = "/conversations/new" }

    it "creates the conversation" do
      session[:user_id] = alice.id
      post :create, conversation: {recipient_id: bob.id, title: "Hi", message: {body: "Hello"}}
      expect(alice.conversations.count).to eq(1)
    end

    it "redirects to the inbox" do
      session[:user_id] = alice.id
      post :create, conversation: {recipient_id: bob.id, title: "Hi", message: {body: "Hello"}}
      expect(response).to redirect_to conversations_path
    end

    it "redirects back to the new conversation page if the message is blank" do
      session[:user_id] = alice.id
      post :create, conversation: {recipient_id: bob.id, title: "Hi", message: {body: ""}}
      expect(response).to redirect_to new_conversation_path
    end

    it "deletes the conversation if the message is blank" do
      session[:user_id] = alice.id
      post :create, conversation: {recipient_id: bob.id, title: "Hi", message: {body: ""}}
      expect(alice.conversations.count).to eq(0)
    end

    it "redirects to the login page for unauthenticated users" do
      post :create, conversation: {recipient_id: bob.id, title: "Hi", message: {body: ""}}
      expect(response).to redirect_to login_path
    end
  end

  describe "POST trash" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }
    let(:bob) { Fabricate(:user, city: la) }
    let(:conv) { Conversation.create(sender: alice, recipient: bob, title: "Hi") }
    before { Message.create(body: "Hello", user: alice, conversation: conv) }

    it "sends the conversation to the trash" do
      session[:user_id] = alice.id
      post :trash, conversation_check: [alice.conversations.first.id]
      expect(alice.conversations.first.sender_trash).to eq(true)
    end

    it "removes the conversation from the trash" do
      session[:user_id] = alice.id
      post :trash, conversation_check: [alice.conversations.first.id]
      post :trash, conversation_check: [alice.conversations.first.id]
      expect(alice.conversations.first.sender_trash).to eq(false)
    end

    it "redirects to the login page for unauthenticated users" do
      post :trash, conversation_check: [alice.conversations.first.id]
      expect(response).to redirect_to login_path
    end
  end
end
