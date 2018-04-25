require 'spec_helper'

describe BusinessesController do
  describe "GET new" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }

    it "sets @review if logged in" do
      session[:user_id] = alice.id
      get :new, city_id: la.id
      expect(assigns(:business)).to be_instance_of(Business)
    end

    it "redirects to login path if not logged in" do
      get :new, city_id: la.id
      expect(response).to redirect_to login_path
    end
  end

  describe "POST create" do
    context "for authenticated users" do
      let(:restaurants) { Fabricate(:category) }
      let(:burgers) { Fabricate(:sub_category, category: restaurants) }
      let(:ca) { Fabricate(:state) }
      let(:la) { la = Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      before { session[:user_id] = alice.id }

      it "redirects to the details page" do
        post :create, city_id: la.id, business: {name: "Fatburger", address: "123 Main St",
          zip_code: '06516', city_id: la.id, price_range: '$$', phone_number: '5556667777', sub_category_ids: [burgers.id],
          hours_attributes: {"0"=>{"day"=>"1", "opens_at(1i)"=>"1", "opens_at(2i)"=>"1", "opens_at(3i)"=>"1", "opens_at(4i)"=>"03", "opens_at(5i)"=>"", "closes_at(1i)"=>"1",
            "closes_at(2i)"=>"1", "closes_at(3i)"=>"1", "closes_at(4i)"=>"10", "closes_at(5i)"=>""},
            "1"=>{"day"=>"2", "opens_at(1i)"=>"1", "opens_at(2i)"=>"1", "opens_at(3i)"=>"1",
              "opens_at(4i)"=>"", "opens_at(5i)"=>"", "closes_at(1i)"=>"1", "closes_at(2i)"=>"1",
              "closes_at(3i)"=>"1", "closes_at(4i)"=>"", "closes_at(5i)"=>""}}}

        expect(response).to redirect_to details_city_business_path(la, Business.first)
      end

      it "created the business" do
        post :create, city_id: la.id, business: {name: "Fatburger", address: "123 Main St",
          zip_code: '06516', city_id: la.id, price_range: '$$', phone_number: '5556667777', sub_category_ids: [burgers.id],
          hours_attributes: {"0"=>{"day"=>"1", "opens_at(1i)"=>"1", "opens_at(2i)"=>"1", "opens_at(3i)"=>"1", "opens_at(4i)"=>"03", "opens_at(5i)"=>"", "closes_at(1i)"=>"1",
            "closes_at(2i)"=>"1", "closes_at(3i)"=>"1", "closes_at(4i)"=>"10", "closes_at(5i)"=>""},
            "1"=>{"day"=>"2", "opens_at(1i)"=>"1", "opens_at(2i)"=>"1", "opens_at(3i)"=>"1",
              "opens_at(4i)"=>"", "opens_at(5i)"=>"", "closes_at(1i)"=>"1", "closes_at(2i)"=>"1",
              "closes_at(3i)"=>"1", "closes_at(4i)"=>"", "closes_at(5i)"=>""}}}

        expect(Business.count).to eq(1)
      end

      it "displays an error message if a required field is blank" do
        post :create, city_id: la.id, business: {address: "123 Main St",
          zip_code: '06516', city_id: la.id, price_range: '$$', phone_number: '5556667777', sub_category_ids: [burgers.id],
          hours_attributes: {"0"=>{"day"=>"1", "opens_at(1i)"=>"1", "opens_at(2i)"=>"1", "opens_at(3i)"=>"1", "opens_at(4i)"=>"03", "opens_at(5i)"=>"", "closes_at(1i)"=>"1",
            "closes_at(2i)"=>"1", "closes_at(3i)"=>"1", "closes_at(4i)"=>"10", "closes_at(5i)"=>""},
            "1"=>{"day"=>"2", "opens_at(1i)"=>"1", "opens_at(2i)"=>"1", "opens_at(3i)"=>"1",
              "opens_at(4i)"=>"", "opens_at(5i)"=>"", "closes_at(1i)"=>"1", "closes_at(2i)"=>"1",
              "closes_at(3i)"=>"1", "closes_at(4i)"=>"", "closes_at(5i)"=>""}}}

        expect(flash[:error]).to be_present
      end

      it "redirects back to the new page if a required field is blank" do
        post :create, city_id: la.id, business: {address: "123 Main St",
          zip_code: '06516', city_id: la.id, price_range: '$$', phone_number: '5556667777', sub_category_ids: [burgers.id],
          hours_attributes: {"0"=>{"day"=>"1", "opens_at(1i)"=>"1", "opens_at(2i)"=>"1", "opens_at(3i)"=>"1", "opens_at(4i)"=>"03", "opens_at(5i)"=>"", "closes_at(1i)"=>"1",
            "closes_at(2i)"=>"1", "closes_at(3i)"=>"1", "closes_at(4i)"=>"10", "closes_at(5i)"=>""},
            "1"=>{"day"=>"2", "opens_at(1i)"=>"1", "opens_at(2i)"=>"1", "opens_at(3i)"=>"1",
              "opens_at(4i)"=>"", "opens_at(5i)"=>"", "closes_at(1i)"=>"1", "closes_at(2i)"=>"1",
              "closes_at(3i)"=>"1", "closes_at(4i)"=>"", "closes_at(5i)"=>""}}}

        expect(response).to redirect_to new_city_business_path(la)
      end
    end

    context "for unauthenticated users" do
      let(:ca) { Fabricate(:state) }
      let(:la) { la = Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }

      it "redirects to the login path" do
        post :create, city_id: la.id, business: {name: "Fatburger", address: "123 Main St", zip_code: '06516', city_id: la.id, price_range: '$$', phone_number: '5556667777'}
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET edit" do
    let(:restaurants) { Fabricate(:category) }
    let(:burgers) { Fabricate(:sub_category, category: restaurants) }
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }
    let(:biz) { Fabricate(:business, city: la, owner: alice, sub_categories: [burgers]) }

    it "sets @business if logged in" do
      session[:user_id] = alice.id
      get :edit, city_id: la.slug, id: biz.slug
      expect(assigns(:business)).to eq(biz)
    end

    it "redirects to login path if not logged in" do
      get :edit, city_id: la.slug, id: biz.slug
      expect(response).to redirect_to login_path
    end
  end

  describe "PATCH update" do
    context "for authenticated users" do
      let(:restaurants) { Fabricate(:category) }
      let(:burgers) { Fabricate(:sub_category, category: restaurants) }
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: alice, sub_categories: [burgers]) }
      before { session[:user_id] = alice.id }
      before { patch :update, city_id: la.slug, id: biz.slug, business: {name: "Fatburger", address: "123 Main St",
        zip_code: '06516', city_id: la.id, price_range: '$$', phone_number: '5556667777', sub_category_ids: [burgers.id],
        hours_attributes: {"0"=>{"day"=>"1", "opens_at(1i)"=>"1", "opens_at(2i)"=>"1", "opens_at(3i)"=>"1", "opens_at(4i)"=>"03", "opens_at(5i)"=>"", "closes_at(1i)"=>"1",
          "closes_at(2i)"=>"1", "closes_at(3i)"=>"1", "closes_at(4i)"=>"10", "closes_at(5i)"=>""},
          "1"=>{"day"=>"2", "opens_at(1i)"=>"1", "opens_at(2i)"=>"1", "opens_at(3i)"=>"1",
            "opens_at(4i)"=>"", "opens_at(5i)"=>"", "closes_at(1i)"=>"1", "closes_at(2i)"=>"1",
            "closes_at(3i)"=>"1", "closes_at(4i)"=>"", "closes_at(5i)"=>""}}} }

      it "redirects to the details page" do
        expect(response).to redirect_to details_city_business_path(la, Business.first)
      end

      it "updated the business" do
        expect(biz.reload.name).to eq("Fatburger")
      end
    end

    context "for unauthenticated users" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: alice) }

      it "redirects to the login path" do
        patch :update, city_id: la.slug, id: biz.slug, business: {name: "Fatburger", address: "123 Main St", zip_code: '06516', city_id: la.id, price_range: '$$', phone_number: '5556667777'}
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET details" do
    context "for authenticated users" do
      let(:restaurants) { Fabricate(:category) }
      let(:burgers) { Fabricate(:sub_category, category: restaurants) }
      let(:ca) { Fabricate(:state) }
      let(:la) { la = Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      before { session[:user_id] = alice.id }

      it "redirects to the edit business page if the business has no sub categories" do
        post :create, city_id: la.slug, business: {name: "Fatburger", address: "123 Main St",
          zip_code: '06516', city_id: la.id, price_range: '$$', phone_number: '5556667777', sub_category_ids: [],
          hours_attributes: {"0"=>{"day"=>"1", "opens_at(1i)"=>"1", "opens_at(2i)"=>"1", "opens_at(3i)"=>"1", "opens_at(4i)"=>"03", "opens_at(5i)"=>"", "closes_at(1i)"=>"1",
            "closes_at(2i)"=>"1", "closes_at(3i)"=>"1", "closes_at(4i)"=>"10", "closes_at(5i)"=>""},
            "1"=>{"day"=>"2", "opens_at(1i)"=>"1", "opens_at(2i)"=>"1", "opens_at(3i)"=>"1",
              "opens_at(4i)"=>"", "opens_at(5i)"=>"", "closes_at(1i)"=>"1", "closes_at(2i)"=>"1",
              "closes_at(3i)"=>"1", "closes_at(4i)"=>"", "closes_at(5i)"=>""}}}
        get :details, city_id: la.slug, id: Business.first.slug

        expect(response).to redirect_to edit_city_business_path(la, Business.first)
      end
    end

    context "for unauthenticated users" do
      let(:restaurants) { Fabricate(:category) }
      let(:burgers) { Fabricate(:sub_category, category: restaurants) }
      let(:ca) { Fabricate(:state) }
      let(:la) { la = Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: alice) }

      it "redirects to the login page" do
        get :details, city_id: la.slug, id: biz.slug
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST write_details" do
    let(:restaurants) { Fabricate(:category) }
    let(:burgers) { Fabricate(:sub_category, category: restaurants) }
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }
    let(:biz) { Fabricate(:business, city: la, owner: alice, sub_categories: [burgers]) }
    let(:delivery) { CategoryOption.create(name: "Delivery", options: ["Yes", "No"], searchable: false, category: restaurants) }
    let(:takeout) { CategoryOption.create(name: "Takeout", options: ["Yes", "No"], searchable: false, category: restaurants) }

    it "redirects to the business page for authenticated users" do
      session[:user_id] = alice.id
      post :write_details, city_id: la.slug, id: biz.slug,
        business: {business_options_attributes: {"0"=>{category_option_id: delivery.id,
          business_id: biz.id, option: "No"},
          "1"=>{category_option_id: takeout.id, business_id: biz.id, option: "Yes"}}}
      expect(response).to redirect_to city_business_path(la, biz)
    end

    it "redirects to the login page for unauthenticated user" do
      post :write_details, city_id: la.slug, id: biz.slug,
        business: {business_options_attributes: {"0"=>{category_option_id: delivery.id,
          business_id: biz.id, option: "No"},
          "1"=>{category_option_id: takeout.id, business_id: biz.id, option: "Yes"}}}
      expect(response).to redirect_to login_path
    end
  end

  describe "DELETE destroy" do
    context "for authenticated users" do
      let(:restaurants) { Fabricate(:category) }
      let(:burgers) { Fabricate(:sub_category, category: restaurants) }
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: alice, sub_categories: [burgers]) }
      before { session[:user_id] = alice.id }
      before { delete :destroy, id: biz.slug, city_id: la.slug }

      it "deletes the business" do
        expect(alice.businesses.count).to eq(0)
      end

      it "redirects to the user businesses page" do
        expect(response).to redirect_to user_path(alice, page: 'businesses')
      end
    end

    context "for unauthenticated users" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: alice) }
      before { delete :destroy, id: biz.slug, city_id: la.slug }

      it "does not delete the business" do
        expect(alice.businesses.count).to eq(1)
      end

      it "redirects to the login path" do
        expect(response).to redirect_to login_path
      end
    end

    context "for authenticated non-admins and non-business owners" do
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: alice) }
      before { session[:user_id] = bob.id }
      before { delete :destroy, id: biz.slug, city_id: la.slug }

      it "does not delete the business" do
        expect(alice.businesses.count).to eq(1)
      end

      it "redirects to the root path" do
        expect(response).to redirect_to root_path
      end
    end

    context "for admins" do
      let(:restaurants) { Fabricate(:category) }
      let(:burgers) { Fabricate(:sub_category, category: restaurants) }
      let(:ca) { Fabricate(:state) }
      let(:la) { Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:admin, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: bob, sub_categories: [burgers]) }
      before { session[:user_id] = alice.id }
      before { delete :destroy, id: biz.slug, city_id: la.slug }

      it "deletes the business" do
        expect(bob.businesses.count).to eq(0)
      end

      it "redirects to the root page" do
        expect(response).to redirect_to root_path
      end
    end
  end
end
