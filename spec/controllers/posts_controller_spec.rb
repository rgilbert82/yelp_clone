require 'spec_helper'

describe PostsController do
  describe "POST create" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:sports) { Fabricate(:topic_category) }
    let(:alice) { Fabricate(:user, city: la) }
    let(:yankees) { Topic.create(title: "NYY", city: la, user: alice, topic_category: sports) }

    it "creates the post" do
      session[:user_id] = alice.id
      post :create, city_id: la.slug, topic_id: yankees.slug, post: { body: "Hello" }
      expect(yankees.posts.count).to eq(1)
    end

    it "redirects to the topic page" do
      session[:user_id] = alice.id
      post :create, city_id: la.slug, topic_id: yankees.slug, post: { body: "Hello" }
      expect(response).to redirect_to city_topic_path(la, yankees)
    end

    it "redirects to the login page for unauthenticated users" do
      post :create, city_id: la.slug, topic_id: yankees.slug, post: { body: "Hello" }
      expect(response).to redirect_to login_path
    end
  end
end
