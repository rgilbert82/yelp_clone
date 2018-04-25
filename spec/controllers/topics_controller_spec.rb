require "spec_helper"

describe TopicsController do
  describe "GET new" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }

    it "sets @topic if logged in" do
      session[:user_id] = alice.id
      get :new, city_id: la.slug
      expect(assigns(:topic)).to be_instance_of(Topic)
    end

    it "redirects to the login page for unauthenticated users" do
      get :new, city_id: la.slug
      expect(response).to redirect_to login_path
    end
  end

  describe "POST create" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:sports) { Fabricate(:topic_category) }
    let(:alice) { Fabricate(:user, city: la) }

    it "creates the topic" do
      session[:user_id] = alice.id
      post :create, city_id: la.slug, topic: {title: "Hello", city_id: la.id, topic_category_id: sports.id, post: {body: "something here"}}
      expect(la.topics.count).to eq(1)
    end

    it "creates a post for the topic" do
      session[:user_id] = alice.id
      post :create, city_id: la.slug, topic: {title: "Hello", city_id: la.id, topic_category_id: sports.id, post: {body: "something here"}}
      expect(la.topics.first.posts.count).to eq(1)
    end

    it "redirects to the topic page" do
      session[:user_id] = alice.id
      post :create, city_id: la.slug, topic: {title: "Hello", city_id: la.id, topic_category_id: sports.id, post: {body: "something here"}}
      expect(response).to redirect_to city_topic_path(la, la.topics.first)
    end

    it "doesn't create the topic if the topic doesn't have a title" do
      session[:user_id] = alice.id
      post :create, city_id: la.slug, topic: {title: "", city_id: la.id, topic_category_id: sports.id, post: {body: "something here"}}
      expect(la.topics.count).to eq(0)
    end

    it "doesn't create the topic if the message is blank" do
      session[:user_id] = alice.id
      post :create, city_id: la.slug, topic: {title: "Hello", city_id: la.id, topic_category_id: sports.id, post: {body: ""}}
      expect(la.topics.count).to eq(0)
    end

    it "redirects to the new topic page if there are errors" do
      session[:user_id] = alice.id
      post :create, city_id: la.slug, topic: {title: "", city_id: la.id, topic_category_id: sports.id, post: {body: "something here"}}
      expect(response).to redirect_to new_city_topic_path(la)
    end

    it "redirects to the login page for unauthenticated users" do
      post :create, city_id: la.slug, topic: {title: "Hello", city_id: la.id, topic_category_id: sports.id, post: {body: "something here"}}
      expect(response).to redirect_to login_path
    end
  end
end
