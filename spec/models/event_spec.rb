# frozen_string_literal: true

require "rails_helper"

RSpec.describe Event, type: :model do
  let(:category1) { create(:category) }
  let(:category2) { create(:category) }
  let(:user) { create(:user) }
  let!(:upcoming_event) { create(:event, title: "Folk Festival", date: "#{Time.now + 2.week.to_i}", category_id: category1.id) }
  let!(:upcoming_event_SF) { create(:event, title: "Jazz Festival", address: "San Francisco, CA", date: "#{Time.now + 3.week.to_i}", category_id: category2.id) }
  let(:ticket) { create(:ticket, title: "VIP", price: 100, event_id: upcoming_event_SF.id) }
  let!(:purchased_ticket) { create(:purchased_ticket, user_id: user.id, event_id: upcoming_event_SF.id, ticket_id: ticket.id) }

  it "creates an event" do
    expect(upcoming_event.title).to eq("Folk Festival")
  end

  it "belongs to a user" do
    should belong_to(:user)
  end

  it "should have many passive_attends" do
    should have_many(:passive_attends)
  end

  it "should have many attendees" do
    should have_many(:attendees)
  end

  it "should have many tickets" do
    should have_many(:tickets)
  end

  it "should have many purchased_tickets" do
    should have_many(:purchased_tickets)
  end

  it "should have many comments" do
    should have_many(:comments)
  end

  it "should validate :title required" do
    should validate_presence_of(:title)
  end

  it "should validate :description required" do
    should validate_presence_of(:description)
  end

  it "should validate :address required" do
    should validate_presence_of(:address)
  end

  it "should validate :category_id required" do
    should validate_presence_of(:category_id)
  end

  it "should return a list of upcoming events" do
    results = Event.upcoming
    event_titles = results.pluck(:title)
    expect(event_titles).to include(upcoming_event.title)
  end

  it "should return a list of past events" do
    results = Event.past
    event_titles = results.pluck(:title)
    expect(event_titles).to_not include(upcoming_event.title)
  end

  it "should return true if valid date" do
    valid_result = upcoming_event.has_valid_date?
    expect(valid_result).to be true
  end

  it "should return matching event - search category" do
    search_params = { category: category1.id.to_s }
    results = Event.search(search_params)
    event_titles = results.pluck(:title)
    expect(event_titles).to include(upcoming_event.title)
    expect(event_titles).to_not include(upcoming_event_SF.title)
  end

  it "should return matching event - search desc" do
    search_params = { search: "#{upcoming_event.title}" }
    results = Event.search(search_params)
    event_titles = results.pluck(:title)
    expect(event_titles).to include(upcoming_event.title)
    expect(event_titles).to_not include(upcoming_event_SF.title)
  end

  it "should reutrn matching event - search location" do
    search_params = { timeline: "Past Events" }
    results = Event.search(search_params)
    event_titles = results.pluck(:title)
    expect(event_titles).to_not include(upcoming_event.title)
    expect(event_titles).to_not include(upcoming_event_SF.title)
  end

  it "should return true if no tickets have been sold" do 
    result = upcoming_event.tickets_not_sold?
    expect(result).to eq(true)
  end 

  it "should return false if tickets have been sold" do 
    result = upcoming_event_SF.tickets_not_sold?
    expect(result).to eq(false)
  end 

end
