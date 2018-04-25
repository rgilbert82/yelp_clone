require 'spec_helper'

describe DonationsController do
  describe "POST create" do
    context "for successful charge" do
      let(:charge) { double(:charge, successful?: true) }

      it "should redirect to the root page" do
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        post :create
        expect(response).to redirect_to root_path
      end

      it "should set a success message" do
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        post :create
        expect(flash[:success]).to be_present
      end
    end

    context "for unsuccessful charge" do
      let(:charge) { double(:charge, successful?: false, error_message: "Error!") }
      before { request.env["HTTP_REFERER"] = "/donate" }

      it "should redirect back to the donate page" do
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        post :create
        expect(response).to redirect_to donate_path
      end

      it "should set an error message" do
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        post :create
        expect(flash[:error]).to eq("Error!")
      end
    end
  end
end
