# frozen_string_literal: true

FactoryBot.define do
  factory :purchased_ticket do
    ticket_guid { SecureRandom.base64.delete("/+=")[0, 8] }
    redeemed { false }
    event
    ticket
    user
  end
end
