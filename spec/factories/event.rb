# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title { "Rock Concert" }
    description { "Great rock show" }
    address { "1400 Pearl St, Boulder, CO" }
    date { "#{Time.now + 2.week.to_i}" }
    category
    user
  end
end
