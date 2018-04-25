require 'spec_helper'

describe Admin::TopicsController do
  describe "DELETE destroy" do
    context "with valid admin" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:sports) { Fabricate(:topic_category) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:carl) { Fabricate(:admin, city: la) }
      let(:yankees) { Topic.create(title: "NYY", city: la, user: alice, topic_category: sports) }
      before { session[:user_id] = carl.id }
      before { request.env["HTTP_REFERER"] = "/u" }
      before { delete :destroy, id: yankees.id }

      it "deletes the topic" do
        expect(Topic.count).to eq(0)
      end

      it "redirects back to the topics index" do
        expect(response).to redirect_to users_path
      end
    end

    context "without valid admin" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:sports) { Fabricate(:topic_category) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      let(:carl) { Fabricate(:admin, city: la) }
      let(:yankees) { Topic.create(title: "NYY", city: la, user: alice, topic_category: sports) }
      before { request.env["HTTP_REFERER"] = "/u" }

      it "doesn't delete a topic for unauthenticated users" do
        delete :destroy, id: yankees.id
        expect(Topic.count).to eq(1)
      end

      it "doesn't allow non-admins to delete topics" do
        session[:user_id] = bob.id
        delete :destroy, id: yankees.id
        expect(Topic.count).to eq(1)
      end

      it "redirects to the root path" do
        delete :destroy, id: yankees.id
        expect(response).to redirect_to root_path
      end

      it "sets an error message" do
        delete :destroy, id: yankees.id
        expect(flash[:error]).to eq("You are not authorized to do that.")
      end
    end
  end
end
