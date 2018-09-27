# frozen_string_literal: true

class Charge
  def self.set_user_keys
    # Change this to get the keys from the user object. Encrypt in and out. Add to form
    Rails.configuration.stripe[:publishable_key] = ENV["PUBLISHABLE_KEY_STRIPE_TEST"]
    Rails.configuration.stripe[:secret_key] = ENV["SECRET_KEY_STRIPE_TEST"]
    Stripe.api_key = ENV["SECRET_KEY_STRIPE_TEST"]
  end
end
