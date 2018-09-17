# frozen_string_literal: true

FactoryBot.define do
  factory :attends do
    attendee_id
    attended_event_id
  end
end
