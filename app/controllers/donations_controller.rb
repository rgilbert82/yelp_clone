class DonationsController < ApplicationController
  before_action :set_categories

  def new
  end

  def create
    if logged_in?
      charge_description = "Yelp Clone donation from #{current_user.email}."
    else
      charge_description = "Yelp Clone donation from anonymous user."
    end

    charge = StripeWrapper::Charge.create(
      :amount => params[:amount],
      :card => params[:stripeToken],
      :description => charge_description
    )

    if charge.successful?
      flash[:success] = "Thank you for your generous donation of #{number_to_currency(params[:amount])}."
      redirect_to root_path
    else
      flash[:error] = charge.error_message
      redirect_back(fallback_location: donate_path)
    end
  end

  def test_cards
  end

  private

  def number_to_currency(number)
    "$#{number[0...-2]}.#{number[-2..-1]}" if number
  end
end
