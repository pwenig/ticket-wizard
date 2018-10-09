# frozen_string_literal: true

Rails.configuration.stripe = {
  publishable_key: ENV["PUBLISHABLE_KEY_STRIPE_TEST"],
  secret_key: ENV["SECRET_KEY_STRIPE_TEST"]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]