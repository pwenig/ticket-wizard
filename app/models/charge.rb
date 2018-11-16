# frozen_string_literal: true

class Charge
  def self.set_user_keys(user)
    Rails.configuration.stripe = {
      :publishable_key => user.stripe_publishable_key,
      :secret_key      => user.stripe_secret_key
    }
    Stripe.api_key = Rails.configuration.stripe[:secret_key]
  end
end
