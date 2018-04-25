require "spec_helper"

describe MessagesController do
  describe "POST create" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }
    let(:bob) { Fabricate(:user, city: la) }
    let(:conv) { Conversation.create(sender: alice, recipient: bob, title: "Hi") }
    before { Message.create(body: "Hello", user: alice, conversation: conv) }

    it "creates the message" do
      session[:user_id] = alice.id
      post :create, conversation_id: conv.id, message: { body: "Something" }
      expect(conv.messages.count).to eq(2)
    end

    it "redirects to the conversation page" do
      session[:user_id] = alice.id
      post :create, conversation_id: conv.id, message: { body: "Something" }
      expect(response).to redirect_to conversation_path(conv)
    end

    it "redirects to the login page for unauthenticated users" do
      post :create, conversation_id: conv.id, message: { body: "Something" }
      expect(response).to redirect_to login_path
    end
  end
end
