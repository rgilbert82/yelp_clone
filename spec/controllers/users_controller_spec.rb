require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      before do
        ca = Fabricate(:state)
        la = Fabricate(:city, state: ca)
        post :create, user: { name: "Alice", email: "alice@email.com", password: 'password', city_id: la.id }
      end

      it "created the user" do
        expect(User.count).to eq(1)
      end

      it "redirects to the root page" do
        expect(response).to redirect_to root_path
      end
    end

    context "with invalid input" do
      before do
        request.env["HTTP_REFERER"] = "/"
        post :create, user: { password: "password", name: "John Doe" }
      end

      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "redirect back to the previous page" do
        expect(response).to redirect_to root_path
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end

  describe "GET edit" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }

    it "sets @user if logged in" do
      session[:user_id] = alice.id
      get :edit, id: alice.slug
      expect(assigns(:user)).to eq(alice)
    end

    it "redirects to login path if not logged in" do
      get :edit, id: alice.slug
      expect(response).to redirect_to login_path
    end
  end

  describe "PATCH update" do
    context "for authenticated users" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      before { session[:user_id] = alice.id }

      it "redirects to the user page" do
        patch :update, id: alice.slug, user: {name: "Jane Doe", email: "alice@email.com", password: 'password'}
        expect(response).to redirect_to user_path(User.first)
      end

      it "updated the user" do
        patch :update, id: alice.slug, user: {name: "Jane Doe", email: "alice@email.com", password: 'password'}
        expect(alice.reload.name).to eq("Jane Doe")
      end
    end

    context "for unauthenticated users" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }

      it "redirects to the login path" do
        patch :update, id: alice.slug, user: {name: "Jane Doe", email: "alice@email.com", password: 'password'}
        expect(response).to redirect_to login_path
      end
    end
  end
end
