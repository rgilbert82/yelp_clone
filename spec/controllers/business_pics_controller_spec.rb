require "spec_helper"

describe BusinessPicsController do
  describe "POST create" do
    let(:restaurants) { Fabricate(:category) }
    let(:burgers) { Fabricate(:sub_category, category: restaurants) }
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }
    let(:biz) { Fabricate(:business, city: la, owner: alice, sub_categories: [burgers]) }
    let(:image_file) { fixture_file_upload('files/fatburger-pic.jpg', 'image/jpg') }
    before { request.env["HTTP_REFERER"] = "/" }

    it "creates a business pic if logged in" do
      session[:user_id] = alice.id
      post :create, city_id: la.slug, business_id: biz.slug, business_pic: {image: image_file }
      expect(biz.business_pics.count).to eq(1)
    end

    it "redirects back to the previous page" do
      session[:user_id] = alice.id
      post :create, city_id: la.slug, business_id: biz.slug, business_pic: {image: image_file }
      expect(response).to redirect_to root_path
    end

    it "creates a flash notice if the image is uploaded successfully" do
      session[:user_id] = alice.id
      post :create, city_id: la.slug, business_id: biz.slug, business_pic: {image: image_file }
      expect(flash[:notice]).to be_present
    end

    it "creates a flash error message if no image is uploaded" do
      session[:user_id] = alice.id
      post :create, city_id: la.slug, business_id: biz.slug, business_pic: {image: nil}
      expect(flash[:error]).to be_present
    end

    it "redirects to the login page for unauthenticated users" do
      post :create, city_id: la.slug, business_id: biz.slug, business_pic: {image: image_file }
      expect(response).to redirect_to login_path
    end
  end
end
