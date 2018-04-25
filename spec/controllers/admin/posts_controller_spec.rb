require 'spec_helper'

describe Admin::PostsController do
  describe "DELETE destroy" do
    context "with valid admin" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:sports) { Fabricate(:topic_category) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:carl) { Fabricate(:admin, city: la) }
      let(:yankees) { Topic.create(title: "NYY", city: la, user: alice, topic_category: sports) }
      let(:jeter) { Post.create(body: "Hall of fame Yankee!", user: alice, topic: yankees) }
      before { session[:user_id] = carl.id }
      before { request.env["HTTP_REFERER"] = "/u" }
      before { delete :destroy, id: jeter.id }

      it "deletes the post" do
        expect(Post.count).to eq(0)
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
      let(:jeter) { Post.create(body: "Hall of fame Yankee!", user: alice, topic: yankees) }
      before { request.env["HTTP_REFERER"] = "/u" }

      it "doesn't delete a post for unauthenticated users" do
        delete :destroy, id: jeter.id
        expect(Post.count).to eq(1)
      end

      it "doesn't allow non-admins to delete posts" do
        session[:user_id] = bob.id
        delete :destroy, id: jeter.id
        expect(Post.count).to eq(1)
      end

      it "redirects to the root path" do
        delete :destroy, id: jeter.id
        expect(response).to redirect_to root_path
      end

      it "sets an error message" do
        delete :destroy, id: jeter.id
        expect(flash[:error]).to eq("You are not authorized to do that.")
      end
    end
  end
end
