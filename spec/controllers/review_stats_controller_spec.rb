require "spec_helper"

describe ReviewStatsController do
  describe "POST status" do
    let(:ca) { Fabricate(:state) }
    let(:la) { la = Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }
    let(:bob) { Fabricate(:user, city: la) }
    let(:biz) { Fabricate(:business, city: la, owner: bob) }
    let(:three_star) { Fabricate(:review, business: biz, user: alice) }
    before { request.env["HTTP_REFERER"] = "/" }

    it "creates the review stat" do
      session[:user_id] = alice.id
      xhr :post, :status, city_id: la.slug, business_id: biz.slug, id: three_star.id, stat: "funny"
      expect(three_star.review_stats.count).to eq(1)
    end

    it "updates the stat" do
      session[:user_id] = alice.id
      xhr :post, :status, city_id: la.slug, business_id: biz.slug, id: three_star.id, stat: "funny"
      expect(three_star.review_stats.first.funny).to eq(true)
    end

    it "updates the stat again" do
      session[:user_id] = alice.id
      xhr :post, :status, city_id: la.slug, business_id: biz.slug, id: three_star.id, stat: "funny"
      xhr :post, :status, city_id: la.slug, business_id: biz.slug, id: three_star.id, stat: "funny"
      expect(three_star.review_stats.first.funny).to eq(false)
    end

    it "redirects to the login page for unauthenticated users" do
      post :status, city_id: la.slug, business_id: biz.slug, id: three_star.id, stat: "funny"
      expect(response).to redirect_to login_path
    end
  end
end
