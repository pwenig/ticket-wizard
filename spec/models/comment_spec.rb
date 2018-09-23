# frozen_string_literal: true

require "rails_helper"

RSpec.describe Comment, type: :model do
  it "belongs to a user" do
    should belong_to(:user)
  end

  it "belongs to an event" do
    should belong_to(:event)
  end

  it "should validate :user_id required" do
    should validate_presence_of(:user_id)
  end

  it "should validate :event_id required" do
    should validate_presence_of(:event_id)
  end

  it "should validate :body required" do
    should validate_presence_of(:body)
  end
end
