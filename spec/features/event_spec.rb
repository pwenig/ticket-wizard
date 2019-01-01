# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Events", type: :feature do
  let(:category1) { create(:category) }
  let(:category2) { create(:category, name: "Art") }
  let(:user) { create(:user) }
  let!(:upcoming_event) { create(:event, title: "Folk Festival", date: "#{Time.now + 4.day.to_i}", category_id: category1.id, user_id: user.id) }
  let!(:upcoming_event2) { create(:event, title: "Art Festival", date: "#{Time.now + 3.week.to_i}", category_id: category2.id, user_id: user.id) }

  before do
    sign_in_user(user)
  end

  it "should display all events" do
    visit events_path
    expect(page.text).to include("Art Festival")
    expect(page.text).to include("Folk Festival")
  end

  it "should display filtered events" do
    visit events_path
    select("Art", from: "Category")
    click_on "Search"
    expect(page.text).to include("Art Festival")
    expect(page.text).to_not include("Folk Festival")
  end

  it "should create an event" do
    visit new_event_path
    fill_in("event_title", with: "Heavy Metal Concert")
    fill_in("event_description", with: "Loud event")
    fill_in("txtautocomplete", with: "Boulder Theater")
    year = Date.today + 1.year
    select(year.strftime("%Y"), from: "event_date_1i")
    click_on "create_button"
    event = Event.last
    expect(page.text).to include("Event Created")
    expect(current_path).to eq(new_event_ticket_path(event))
  end

  it "should not create an event with invalid date" do
    current_day = Date.today.strftime("%d")
    visit new_event_path
    fill_in("event_title", with: "Heavy Metal Concert")
    fill_in("event_description", with: "Loud event")
    fill_in("txtautocomplete", with: "Boulder Theater")
    select(current_day.to_i, from: "event_date_3i")
    click_on "create_button"
    expect(page.text).to include("Date must be 1 or more days ahead from now")
  end

  it "should edit an event" do
    visit edit_event_path(upcoming_event, key: upcoming_event.event_guid)
    expect(page.text).to include("Edit Event")
    fill_in("event_title", with: "Folk Festival Updated")
    click_on "edit_button"
    expect(page.text).to include("Folk Festival Updated")
  end

  it "should not edit an event with invalid date" do
    current_day = Date.today.strftime("%d")
    current_month = Date.today.strftime("%B")
    current_year = Date.today.strftime("%Y")
    visit edit_event_path(upcoming_event, key: upcoming_event.event_guid)
    expect(page.text).to include("Edit Event")
    select(current_month, from: "event_date_2i")
    select(current_day.to_i, from: "event_date_3i")
    select(current_year, from: "event_date_1i")
    click_on "edit_button"
    expect(page.text).to include("Date must be 1 or more days ahead from now")
  end

  it "should redirect to root path with invalid event key - show" do
    visit event_path(upcoming_event, key: "foo")
    expect(current_path).to eq(root_path)
  end

  it "should redirect to root path with invalid event key - edit" do
    visit edit_event_path(upcoming_event, key: "foo")
    expect(current_path).to eq(root_path)
  end
end
