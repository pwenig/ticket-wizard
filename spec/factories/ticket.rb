# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    title { "VIP" }
    price { 10.00 }
    description { "All ages" }
    qty_available { 100 }
    onsale_start { "#{Time.now}" }
    onsale_end { "#{Time.now + 2.week.to_i}" }
    ticket_guid { nil }
    redeemed { false }
    user
    event
  end
end
