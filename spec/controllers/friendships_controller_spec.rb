require "spec_helper"

describe FriendshipsController do
  describe "POST friend" do
    context "for authenticated users" do
      let(:ca) { Fabricate(:state) }
      let(:la) { la = Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      before { session[:user_id] = alice.id }

      it "adds Bob as a friend if Bob is not already a friend" do
        xhr :post, :status, id: bob.slug
        expect(alice.friends).to include(bob)
      end

      it "unfriends Bob if Bob is already a friend" do
        Friendship.create(user_id: alice.id, friend_id: bob.id)
        xhr :post, :status, id: bob.slug
        expect(alice.friends).not_to include(bob)
      end

      it "unfriends Bob if Bob is already an inverse friend" do
        Friendship.create(user_id: bob.id, friend_id: alice.id)
        xhr :post, :status, id: bob.slug
        expect(alice.friends).not_to include(bob)
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
