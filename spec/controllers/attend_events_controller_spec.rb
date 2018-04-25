require "spec_helper"

describe AttendEventsController do
  describe "POST status" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }
    let(:biz) { Fabricate(:business, city: la, owner: alice) }
    let(:party) { Fabricate(:event, business: biz) }

    it "creates a UserEvent if user is not already attending the event" do
      session[:user_id] = alice.id
      xhr :post, :status, id: party.slug, business_id: biz.slug, city_id: la.slug
      expect(alice.events.count).to eq(1)
    end

    it "deletes a UserEvent if user is already attending the event" do
      session[:user_id] = alice.id
      xhr :post, :status, id: party.slug, business_id: biz.slug, city_id: la.slug
      xhr :post, :status, id: party.slug, business_id: biz.slug, city_id: la.slug
      expect(alice.events.count).to eq(0)
    end

    it "redirects to the login path for unauthenticated users" do
      post :status, id: party.slug, business_id: biz.slug, city_id: la.slug
      expect(response).to redirect_to login_path
    end
  end
end
