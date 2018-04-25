require 'spec_helper'

describe EventsController do
  describe "GET new" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }
    let(:bob) { Fabricate(:user, city: la) }
    let(:carl) { Fabricate(:admin, city: la) }
    let(:biz) { Fabricate(:business, city: la, owner: alice) }

    it "sets @event if user has privileges" do
      session[:user_id] = alice.id
      get :new, city_id: la.slug, business_id: biz.slug
      expect(assigns(:event)).to be_instance_of(Event)
    end

    it "sets @event if admin" do
      session[:user_id] = carl.id
      get :new, city_id: la.slug, business_id: biz.slug
      expect(assigns(:event)).to be_instance_of(Event)
    end

    it "redirects to the root path if current user doesn't own the business" do
      session[:user_id] = bob.id
      get :new, city_id: la.slug, business_id: biz.slug
      expect(response).to redirect_to root_path
    end

    it "redirects to login path if not logged in" do
      get :new, city_id: la.slug, business_id: biz.slug
      expect(response).to redirect_to login_path
    end
  end

  describe "POST create" do
    context "for users with privileges" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      let(:carl) { Fabricate(:admin, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: alice) }

      it "created the event for users with privileges" do
        session[:user_id] = alice.id
        post :create, city_id: la.slug, business_id: biz.slug, event: {name: "Burger Fest", description: "Eat some burgers", price: "$10", start_time: "2017-03-21 02:09:33.105463" }
        expect(biz.events.count).to eq(1)
      end

      it "created the event for admins" do
        session[:user_id] = carl.id
        post :create, city_id: la.slug, business_id: biz.slug, event: {name: "Burger Fest", description: "Eat some burgers", price: "$10", start_time: "2017-03-21 02:09:33.105463" }
        expect(biz.events.count).to eq(1)
      end

      it "redirects to the business events page for users with privileges" do
        session[:user_id] = alice.id
        post :create, city_id: la.slug, business_id: biz.slug, event: {name: "Burger Fest", description: "Eat some burgers", price: "$10", start_time: "2017-03-21 02:09:33.105463" }
        expect(response).to redirect_to city_business_path(la, biz, page: "events")
      end

      it "redirects to the business events page for admins" do
        session[:user_id] = carl.id
        post :create, city_id: la.slug, business_id: biz.slug, event: {name: "Burger Fest", description: "Eat some burgers", price: "$10", start_time: "2017-03-21 02:09:33.105463" }
        expect(response).to redirect_to city_business_path(la, biz, page: "events")
      end

      it "displays an error message if a required field is blank" do
        session[:user_id] = alice.id
        post :create, city_id: la.slug, business_id: biz.slug, event: { price: "$10", start_time: "2017-03-21 02:09:33.105463" }
        expect(flash[:error]).to be_present
      end

      it "redirects back to the new page if a required field is blank" do
        session[:user_id] = alice.id
        post :create, city_id: la.slug, business_id: biz.slug, event: { price: "$10", start_time: "2017-03-21 02:09:33.105463" }
        expect(response).to redirect_to new_city_business_event_path(la, biz)
      end
    end

    context "for users without privileges" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: alice) }

      it "redirects to the login path for unauthenticated users" do
        post :create, city_id: la.slug, business_id: biz.slug, event: {name: "Burger Fest", description: "Eat some burgers", price: "$10", start_time: "2017-03-21 02:09:33.105463" }
        expect(response).to redirect_to login_path
      end

      it "redirects to the root path for users without privileges" do
        session[:user_id] = bob.id
        post :create, city_id: la.slug, business_id: biz.slug, event: {name: "Burger Fest", description: "Eat some burgers", price: "$10", start_time: "2017-03-21 02:09:33.105463" }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET edit" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }
    let(:bob) { Fabricate(:user, city: la) }
    let(:carl) { Fabricate(:admin, city: la) }
    let(:biz) { Fabricate(:business, city: la, owner: alice) }
    let(:party) { Fabricate(:event, business: biz) }

    it "sets @event if logged in and event creator" do
      session[:user_id] = alice.id
      get :edit, id: party.slug, business_id: biz.slug, city_id: la.slug
      expect(assigns(:event)).to eq(party)
    end

    it "sets @event if admin" do
      session[:user_id] = carl.id
      get :edit, id: party.slug, business_id: biz.slug, city_id: la.slug
      expect(assigns(:event)).to eq(party)
    end

    it "redirects to root path if current user doesn't own the event" do
      session[:user_id] = bob.id
      get :edit, id: party.slug, business_id: biz.slug, city_id: la.slug
      expect(response).to redirect_to root_path
    end

    it "redirects to login path if not logged in" do
      get :edit, id: party.slug, business_id: biz.slug, city_id: la.slug
      expect(response).to redirect_to login_path
    end
  end

  describe "PATCH update" do
    context "for users with event privileges" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      let(:carl) { Fabricate(:admin, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: alice) }
      let(:party) { Fabricate(:event, business: biz) }

      it "redirects to the business events page for users with privileges" do
        session[:user_id] = alice.id
        patch :update, city_id: la.slug, business_id: biz.slug, id: party.slug, event: {name: "Burger Fest", description: "Eat some burgers", price: "$10", start_time: "2017-03-21 02:09:33.105463" }
        expect(response).to redirect_to city_business_path(la, biz, page: "events")
      end

      it "redirects to the business events page for admins" do
        session[:user_id] = carl.id
        patch :update, city_id: la.slug, business_id: biz.slug, id: party.slug, event: {name: "Burger Fest", description: "Eat some burgers", price: "$10", start_time: "2017-03-21 02:09:33.105463" }
        expect(response).to redirect_to city_business_path(la, biz, page: "events")
      end

      it "updated the event for users with privileges" do
        session[:user_id] = alice.id
        patch :update, city_id: la.slug, business_id: biz.slug, id: party.slug, event: {name: "Burger Fest", description: "Eat some burgers", price: "$10", start_time: "2017-03-21 02:09:33.105463" }
        expect(party.reload.name).to eq("Burger Fest")
      end

      it "updated the event for admins" do
        session[:user_id] = carl.id
        patch :update, city_id: la.slug, business_id: biz.slug, id: party.slug, event: {name: "Burger Fest", description: "Eat some burgers", price: "$10", start_time: "2017-03-21 02:09:33.105463" }
        expect(party.reload.name).to eq("Burger Fest")
      end
    end

    context "for users without privileges" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: alice) }
      let(:party) { Fabricate(:event, business: biz) }

      it "redirects to the login path for unauthenticated users" do
        patch :update, city_id: la.slug, business_id: biz.slug, id: party.slug, event: {name: "Burger Fest", description: "Eat some burgers", price: "$10", start_time: "2017-03-21 02:09:33.105463" }
        expect(response).to redirect_to login_path
      end

      it "redirects to the root path if current user doesn't own the event" do
        session[:user_id] = bob.id
        patch :update, city_id: la.slug, business_id: biz.slug, id: party.slug, event: {name: "Burger Fest", description: "Eat some burgers", price: "$10", start_time: "2017-03-21 02:09:33.105463" }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE destroy" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }
    let(:bob) { Fabricate(:user, city: la) }
    let(:carl) { Fabricate(:admin, city: la) }
    let(:biz) { Fabricate(:business, city: la, owner: alice) }
    let(:party) { Fabricate(:event, business: biz) }

    it "deletes the event for users with privileges" do
      session[:user_id] = alice.id
      delete :destroy, id: party.slug, business_id: biz.slug, city_id: la.slug
      expect(biz.events.count).to eq(0)
    end

    it "deletes the event for admins" do
      session[:user_id] = carl.id
      delete :destroy, id: party.slug, business_id: biz.slug, city_id: la.slug
      expect(biz.events.count).to eq(0)
    end

    it "redirects to the businesses events page for users with privileges" do
      session[:user_id] = alice.id
      delete :destroy, id: party.slug, business_id: biz.slug, city_id: la.slug
      expect(response).to redirect_to city_business_path(la, biz, page: "events")
    end

    it "redirects to the businesses events page for admins" do
      session[:user_id] = carl.id
      delete :destroy, id: party.slug, business_id: biz.slug, city_id: la.slug
      expect(response).to redirect_to city_business_path(la, biz, page: "events")
    end

    it "redirects to the root path if current user doesn't own the event" do
      session[:user_id] = bob.id
      delete :destroy, id: party.slug, business_id: biz.slug, city_id: la.slug
      expect(response).to redirect_to root_path
    end

    it "redirects to the login page for unauthenticated users" do
      delete :destroy, id: party.slug, business_id: biz.slug, city_id: la.slug
      expect(response).to redirect_to login_path
    end
  end
end
