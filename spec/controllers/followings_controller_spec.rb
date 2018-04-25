require "spec_helper"

describe FollowingsController do
  describe "POST follow" do
    context "for authenticated users" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      before { session[:user_id] = alice.id }

      it "follows Bob if Bob is not being followed" do
        xhr :post, :status, id: bob.slug
        expect(alice.followings).to include(bob)
      end

      it "unfollows Bob if Bob is already being followed" do
        Follow.create(user_id: alice.id, following_id: bob.id)
        xhr :post, :status, id: bob.slug
        expect(alice.followings).not_to include(bob)
      end
    end

    context "for unauthenticated users" do
      it "redirects to login page for unauthenticated users" do
        ca = Fabricate(:state)
        la = Fabricate(:city, state: ca)
        bob = Fabricate(:user, city: la)
        post :status, id: bob.slug
        expect(response).to redirect_to login_path
      end
    end
  end
end
