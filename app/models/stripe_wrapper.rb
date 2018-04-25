module StripeWrapper
  class Charge
    attr_reader :error_message, :response

    def initialize(options={})
      @response = options[:response]
      @error_message = options[:error_message]
    end

    def self.create(options={})
      begin
        response = Stripe::Charge.create(
          amount: options[:amount],
          currency: 'usd',
          source: options[:card],
          description: options[:description]
        )
        new(response: response) # same as Charge.new(response)
      rescue Stripe::StripeError => e
        new(error_message: e.message)  # returns an object that has no response
      end
    end

    def successful?
      response.present?
    end
  end
end
