require 'spec_helper'

describe Admin::UsersController do
  describe "DELETE destroy" do
    context "with valid admin" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:admin, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      before { session[:user_id] = alice.id }
      before { request.env["HTTP_REFERER"] = "/u" }
      before { delete :destroy, id: bob.id }

      it "deletes the user" do
        expect(User.count).to eq(1)
      end

      it "redirects back to the users index" do
        expect(response).to redirect_to users_path
      end
    end

    context "without valid admin" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      before { request.env["HTTP_REFERER"] = "/u" }

      it "doesn't delete a user for unauthenticated users" do
        alice = Fabricate(:user, city: la)
        bob = Fabricate(:user, city: la)
        delete :destroy, id: bob.id
        expect(User.count).to eq(2)
      end

      it "doesn't allow non-admins to delete users" do
        alice = Fabricate(:user, city: la)
        bob = Fabricate(:user, city: la)
        session[:user_id] = alice.id
        delete :destroy, id: bob.id
        expect(User.count).to eq(2)
      end

      it "redirects to the root path" do
        bob = Fabricate(:user, city: la)
        delete :destroy, id: bob.id
        expect(response).to redirect_to root_path
      end

      it "sets an error message" do
        bob = Fabricate(:user, city: la)
        delete :destroy, id: bob.id
        expect(flash[:error]).to eq("You are not authorized to do that.")
      end
    end
  end
end
