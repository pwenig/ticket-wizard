# frozen_string_literal: true

class Charge
  def self.set_user_keys(user)
    if user.stripe_publishable_key
      Rails.configuration.stripe = {
        :publishable_key => user.stripe_publishable_key,
        :secret_key      => user.stripe_secret_key
      }
      Stripe.api_key = Rails.configuration.stripe[:secret_key]
    else
      Rails.configuration.stripe = {
        :publishable_key => ENV["DEFAULT_PUB_KEY"],
        :secret_key      => ENV["DEFAULT_KEY"]
      }
      Stripe.api_key = Rails.configuration.stripe[:secret_key]
    end 
  end
end
