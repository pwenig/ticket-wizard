# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title { "Rock Concert" }
    description { "Great rock show" }
    address { "1400 Pearl St, Boulder, CO" }
    date { "#{Time.now + 2.week.to_i}" }
    event_guid { SecureRandom.base64.delete("/+=")[0, 8] }
    category
    user

    trait :attendees  do
      after(:create) do |event|
        event.attendees << User.last
      end
    end
  end
end
