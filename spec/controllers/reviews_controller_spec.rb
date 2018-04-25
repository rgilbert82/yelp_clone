require 'spec_helper'

describe ReviewsController do
  describe "GET new" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }
    let(:bob) { Fabricate(:user, city: la) }
    let(:biz) { Fabricate(:business, city: la, owner: bob) }

    it "sets @review if logged in" do
      session[:user_id] = alice.id
      get :new, business_id: biz.slug, city_id: la.slug
      expect(assigns(:review)).to be_instance_of(Review)
    end

    it "redirects to login path if not logged in" do
      get :new, business_id: biz.slug, city_id: la.slug
      expect(response).to redirect_to login_path
    end
  end

  describe "POST create" do
    context "for authenticated users" do
      let(:ca) { Fabricate(:state) }
      let(:la) { la = Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: bob) }
      before { session[:user_id] = alice.id }

      it "redirects to the business page" do
        post :create, business_id: biz.slug, city_id: la.slug, review: { body: "Review body", star_rating: 3 }
        expect(response).to redirect_to city_business_path(la, biz)
      end

      it "created the review" do
        post :create, business_id: biz.slug, city_id: la.slug, review: { body: "Review body", star_rating: 3 }
        expect(Review.count).to eq(1)
      end

      it "displays an error message if the review body is blank" do
        post :create, business_id: biz.slug, city_id: la.slug, review: { body: "", star_rating: 3 }
        expect(flash[:error]).to be_present
      end

      it "redirects back to the new page if the review body is blank" do
        post :create, business_id: biz.slug, city_id: la.slug, review: { body: "", star_rating: 3 }
        expect(response).to redirect_to new_city_business_review_path(la, biz)
      end
    end

    context "for unauthenticated users" do
      let(:ca) { Fabricate(:state) }
      let(:la) { la = Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: bob) }
      before { post :create, business_id: biz.slug, city_id: la.slug, review: { body: "Review body", star_rating: 3 } }

      it "redirects to the login path" do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET edit" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }
    let(:alice) { Fabricate(:user, city: la) }
    let(:bob) { Fabricate(:user, city: la) }
    let(:carl) { Fabricate(:admin, city: la) }
    let(:biz) { Fabricate(:business, city: la, owner: bob) }
    let(:three_star) { Fabricate(:review, business: biz, user: alice) }

    it "sets @review if user has review privileges" do
      session[:user_id] = alice.id
      get :edit, business_id: biz.slug, city_id: la.slug, id: three_star.id
      expect(assigns(:review)).to eq(three_star)
    end

    it "sets @review if user is an admin" do
      session[:user_id] = carl.id
      get :edit, business_id: biz.slug, city_id: la.slug, id: three_star.id
      expect(assigns(:review)).to eq(three_star)
    end

    it "redirects to login path if not logged in" do
      get :edit, business_id: biz.slug, city_id: la.slug, id: three_star.id
      expect(response).to redirect_to login_path
    end

    it "redirects to the root path for users without review privileges" do
      session[:user_id] = bob.id
      get :edit, business_id: biz.slug, city_id: la.slug, id: three_star.id
      expect(response).to redirect_to root_path
    end
  end

  describe "PATCH update" do
    context "for users with review privileges" do
      let(:ca) { Fabricate(:state) }
      let(:la) { la = Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: bob) }
      let(:three_star) { Fabricate(:review, business: biz, user: alice) }
      before { session[:user_id] = alice.id }

      it "redirects to the business page" do
        patch :update, business_id: biz.slug, city_id: la.slug, id: three_star.id, review: { body: "Review body", star_rating: 3 }
        expect(response).to redirect_to city_business_path(la, biz)
      end

      it "updated the review" do
        patch :update, business_id: biz.slug, city_id: la.slug, id: three_star.id, review: { body: "Review body", star_rating: 3 }
        expect(three_star.reload.body).to eq("Review body")
      end

      it "displays an error message if the review body is blank" do
        patch :update, business_id: biz.slug, city_id: la.slug, id: three_star.id, review: { body: "", star_rating: 3 }
        expect(flash[:error]).to be_present
      end

      it "redirects back to the edit page if the review body is blank" do
        patch :update, business_id: biz.slug, city_id: la.slug, id: three_star.id, review: { body: "", star_rating: 3 }
        expect(response).to redirect_to edit_city_business_review_path(la, biz, three_star)
      end
    end

    context "for admins" do
      let(:ca) { Fabricate(:state) }
      let(:la) { la = Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      let(:carl) { Fabricate(:admin, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: bob) }
      let(:three_star) { Fabricate(:review, business: biz, user: alice) }
      before { session[:user_id] = carl.id }

      it "redirects to the business page" do
        patch :update, business_id: biz.slug, city_id: la.slug, id: three_star.id, review: { body: "Review body", star_rating: 3 }
        expect(response).to redirect_to city_business_path(la, biz)
      end

      it "updated the review" do
        patch :update, business_id: biz.slug, city_id: la.slug, id: three_star.id, review: { body: "Review body", star_rating: 3 }
        expect(three_star.reload.body).to eq("Review body")
      end

      it "displays an error message if the review body is blank" do
        patch :update, business_id: biz.slug, city_id: la.slug, id: three_star.id, review: { body: "", star_rating: 3 }
        expect(flash[:error]).to be_present
      end

      it "redirects back to the edit page if the review body is blank" do
        patch :update, business_id: biz.slug, city_id: la.slug, id: three_star.id, review: { body: "", star_rating: 3 }
        expect(response).to redirect_to edit_city_business_review_path(la, biz, three_star)
      end
    end

    context "for users without review privileges" do
      let(:ca) { Fabricate(:state) }
      let(:la) { la = Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: bob) }
      let(:three_star) { Fabricate(:review, business: biz, user: alice, star_rating: 3) }

      it "doesn't update the review for unauthenticated users" do
        patch :update, business_id: biz.slug, city_id: la.slug, id: three_star.id, review: { body: "Review body", star_rating: 5 }
        expect(three_star.star_rating).to eq(3)
      end

      it "doesn't update the review for users without privileges" do
        session[:user_id] = bob.id
        patch :update, business_id: biz.slug, city_id: la.slug, id: three_star.id, review: { body: "Review body", star_rating: 5 }
        expect(three_star.star_rating).to eq(3)
      end

      it "redirects to the login path for unauthenticated users" do
        patch :update, business_id: biz.slug, city_id: la.slug, id: three_star.id, review: { body: "Review body", star_rating: 5 }
        expect(response).to redirect_to login_path
      end

      it "redirects to the root path for users without privileges" do
        session[:user_id] = bob.id
        patch :update, business_id: biz.slug, city_id: la.slug, id: three_star.id, review: { body: "Review body", star_rating: 5 }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE destroy" do
    context "for users with review privileges" do
      let(:ca) { Fabricate(:state) }
      let(:la) { la = Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      let(:carl) { Fabricate(:admin, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: bob) }
      let(:three_star) { Fabricate(:review, business: biz, user: alice) }

      it "deletes the review for users with privileges" do
        session[:user_id] = alice.id
        delete :destroy, business_id: biz.slug, city_id: la.slug, id: three_star.id
        expect(alice.reviews.exists?(three_star.id)).to be(false)
      end

      it "deletes the review for admins" do
        session[:user_id] = carl.id
        delete :destroy, business_id: biz.slug, city_id: la.slug, id: three_star.id
        expect(alice.reviews.exists?(three_star.id)).to be(false)
      end

      it "redirects to the business page for users with privileges" do
        session[:user_id] = alice.id
        delete :destroy, business_id: biz.slug, city_id: la.slug, id: three_star.id
        expect(response).to redirect_to city_business_path(la, biz)
      end

      it "redirects to the business page for admins" do
        session[:user_id] = carl.id
        delete :destroy, business_id: biz.slug, city_id: la.slug, id: three_star.id
        expect(response).to redirect_to city_business_path(la, biz)
      end
    end

    context "for users without privileges" do
      let(:ca) { Fabricate(:state) }
      let(:la) { la = Fabricate(:city, state: ca) }
      let(:alice) { Fabricate(:user, city: la) }
      let(:bob) { Fabricate(:user, city: la) }
      let(:biz) { Fabricate(:business, city: la, owner: bob) }
      let(:three_star) { Fabricate(:review, business: biz, user: alice) }

      it "doesn't delete the review for unauthenticated users" do
        delete :destroy, business_id: biz.slug, city_id: la.slug, id: three_star.id
        expect(alice.reviews.count).to eq(1)
      end

      it "doesn't delete the review for user without privileges" do
        session[:user_id] = bob.id
        delete :destroy, business_id: biz.slug, city_id: la.slug, id: three_star.id
        expect(alice.reviews.count).to eq(1)
      end

      it "redirects to the login path for unauthenticated users" do
        delete :destroy, business_id: biz.slug, city_id: la.slug, id: three_star.id
        expect(response).to redirect_to login_path
      end

      it "redirects to the root path for users without privileges" do
        session[:user_id] = bob.id
        delete :destroy, business_id: biz.slug, city_id: la.slug, id: three_star.id
        expect(response).to redirect_to root_path
      end
    end
  end
end
