require "spec_helper"

describe ForgotPasswordsController do
  describe "POST create" do
    let(:ca) { Fabricate(:state) }
    let(:la) { Fabricate(:city, state: ca) }

    context "with blank input" do
      it "redirects to the forgot password page" do
        post :create, email: ""
        expect(response).to redirect_to forgot_password_path
      end

      it "shows an error message" do
        post :create, email: ""
        expect(flash[:error]).to be_present
      end
    end

    context "with existing email" do
      it "redirects to the forgot password confirmation page" do
        Fabricate(:user, email: "joe@example.com", city: la)
        post :create, email: "joe@example.com"
        expect(response).to redirect_to forgot_password_confirmation_path
      end

      it "sends an email to the email address" do
        Fabricate(:user, email: "joe@example.com", city: la)
        post :create, email: "joe@example.com"
        expect(ActionMailer::Base.deliveries.last.to).to eq(["joe@example.com"])
      end
    end

    context "with non-existing email" do
      it "redirects to the forgot password page" do
        post :create, email: "foo@example.com"
        expect(response).to redirect_to forgot_password_path
      end

      it "shows an error message" do
        post :create, email: "foo@example.com"
        expect(flash[:error]).to be_present
      end
    end
  end
end
