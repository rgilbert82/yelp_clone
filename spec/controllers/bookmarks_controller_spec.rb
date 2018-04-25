require "spec_helper"

describe BookmarksController do
  describe "POST status" do
    context "for authenticated users" do
      let(:restaurants) { Fabricate(:category) }
      let(:burgers) { Fabricate(:sub_category, category: restaurants) }
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: alice, sub_categories: [burgers]) }
      before { session[:user_id] = alice.id }
      before { xhr :post, :status, id: biz.slug, city_id: la.slug }

      it "creates a bookmark for the business" do
        expect(Bookmark.count).to eq(1)
      end

      it "deletes an existing bookmark" do
        xhr :post, :status, id: biz.slug, city_id: la.slug
        expect(Bookmark.count).to eq(0)
      end
    end

    context "for unauthenticated users" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: alice) }
      before { post :status, id: biz.slug, city_id: la.slug }

      it "redirects to the login page" do
        expect(response).to redirect_to login_path
      end
    end
  end
end
