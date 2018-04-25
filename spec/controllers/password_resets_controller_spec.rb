require "spec_helper"

describe PasswordResetsController do
  describe "GET show" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }

    it "renders the show template if the token is valid" do
      alice.update_column(:token, "12345")
      get :show, id: "12345"
      expect(response).to render_template :show
    end

    it "sets @token" do
      alice.update_column(:token, "12345")
      get :show, id: "12345"
      expect(assigns(:token)).to eq("12345")
    end

    it "redirects to the expired token page if the token is invalid" do
      get :show, id: "12345"
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "POST create" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la, password: "old_password") }
    before { request.env["HTTP_REFERER"] = "/" }

    context "with valid token" do
      it "redirects to the sign in page" do
        alice.update_column(:token, "12345")
        post :create, token: "12345", password: "new_password"
        expect(response).to redirect_to login_path
      end

      it "updates the user's password" do
        alice.update_column(:token, "12345")
        post :create, token: "12345", password: "new_password"
        expect(alice.reload.authenticate("new_password")).to be_truthy
      end

      it "sets the flash success message" do
        alice.update_column(:token, "12345")
        post :create, token: "12345", password: "new_password"
        expect(flash[:success]).to be_present
      end

      it "regenerates the user's token" do
        alice.update_column(:token, "12345")
        post :create, token: "12345", password: "new_password"
        expect(alice.reload.token).not_to eq("12345")
      end
    end

    context "with invalid token" do
      it "redirects to the expired_token_path" do
        post :create, token: "12345", password: "some_password"
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end
