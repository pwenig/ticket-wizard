# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "Test User" }
    sequence(:email)  { |n| "test#{n}@test.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
