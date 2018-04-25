require 'spec_helper'

describe StripeWrapper do
  let(:valid_token) do
    Stripe::Token.create(
      :card => {
        :number => "4242424242424242",
        :exp_month => 6,
        :exp_year => 2020,
        :cvc => 314
      }
    ).id
  end

  let(:declined_card_token) do
    Stripe::Token.create(
      :card => {
        :number => "4000000000000002",
        :exp_month => 6,
        :exp_year => 2020,
        :cvc => 314
      }
    ).id
  end

  describe StripeWrapper::Charge do
    describe ".create" do  # User '.' for class methods, '#' for instance methods
      it "makes a successful charge", :vcr do  # Don't forget to setup VCR in spec_helper
        response = StripeWrapper::Charge.create(
          amount: 999,
          card: valid_token,
          description: "A valid charge",
        )

        expect(response).to be_successful
      end

      it "makes a card declined charge", :vcr do
        response = StripeWrapper::Charge.create(
          amount: 999,
          card: declined_card_token,
          description: "An invalid charge",
        )

        expect(response).not_to be_successful
      end

      it "returns the error message for declined charges", :vcr do
        response = StripeWrapper::Charge.create(
          amount: 999,
          card: declined_card_token,
          description: "An invalid charge",
        )

        expect(response.error_message).to be_present
      end
    end
  end
end
