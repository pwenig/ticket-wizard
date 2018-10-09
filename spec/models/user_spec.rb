# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { create(:user, name: "New User") }
  let(:category) { create(:category) }
  let(:event) { create(:event, category_id: category.id, user_id: user.id) }

  it "creates a user" do
    expect(user.name).to eq("New User")
  end

  it "should have many events" do
    should have_many(:events)
  end

  it "should have many purchased_tickets" do
    should have_many(:purchased_tickets)
  end

  it "should have many comments" do
    should have_many(:comments)
  end

  it "should have many active_attends" do
    should have_many(:active_attends)
  end

  it "should have many attending" do
    should have_many(:attending)
  end

  it "should validate :name required" do
    should validate_presence_of :name
  end

  it "should validate :email required" do
    should validate_presence_of :email
  end

  it "should validate :password required" do
    should validate_presence_of :password
  end

  it "returns the hash digest of a string" do
    result = user.digest("password")
    expect(result).to match(/^\$2[ayb]\$.{56}$/)
  end

  it "adds user to attend list for event" do
    expect(user.active_attends.length).to eq(0)
    user.attend(event)
    expect(user.active_attends.length).to eq(1)
    expect(user.active_attends.first.attendee_id).to eq(user.id)
  end

  it "removes a user from the attend list of an event" do
    user.attend(event)
    expect(user.active_attends.length).to eq(1)
    user.unattend(event)
    user.reload
    expect(user.active_attends.length).to eq(0)
  end

  it "returns true if a user is attending an event" do
    user.attend(event)
    expect(user.active_attends.length).to eq(1)
    result = user.attending?(event)
    expect(result).to eq(true)
  end

  it "returns upcoming events for a user" do
    user.attend(event)
    expect(user.active_attends.length).to eq(1)
    upcoming_events = user.upcoming_events
    expect(upcoming_events).to eq([event])
  end
end
