# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "Test User" }
    sequence(:email)  { |n| "test#{n}@test.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { false }
    ops { false }
    stripe_publishable_key {'1234'}
    stripe_secret_key {'abcd'}
  end
end
