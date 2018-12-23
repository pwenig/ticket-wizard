# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    order_ref { SecureRandom.base64.delete("/+=")[0, 8] }
    amount { 100.00 }
    purchased_ticket_ids { [] }
    event
    user
  end
end
