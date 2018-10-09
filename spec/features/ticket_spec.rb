# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Tickets", type: :feature do
  let(:category) { create(:category) }
  let(:user) { create(:user) }
  let!(:event) { create(:event, title: "Folk Festival", date: "#{Time.now + 4.day.to_i}", category_id: category.id, user_id: user.id) }
  let!(:vip_ticket) { create(:ticket, event_id: event.id) }
  before do
    sign_in_user(user)
  end

  it "should create a ticket for an event" do
    visit event_tickets_path(event, key: event.event_guid)
    expect(page.text).to include(event.title)
    expect(page.text).to include("Create Tickets")
    click_on("create-ticket-button")
    expect(page.text).to include("Create Tickets for:")
    expect(page.text).to include(event.title)
    fill_in("ticket_title", with: "General Admission")
    fill_in("ticket_price", with: 25.00)
    fill_in("ticket_qty_available", with: 100)
    click_on("create_button")
    expect(current_path).to eq(event_tickets_path(event))
    expect(page.text).to include("Tickets")
    expect(page.text).to include("General Admission")
  end

  it "should not create a ticket for an event with errors" do
    visit event_tickets_path(event, key: event.event_guid)
    expect(page.text).to include(event.title)
    expect(page.text).to include("Create Tickets")
    click_on("create-ticket-button")
    expect(page.text).to include("Create Tickets for:")
    expect(page.text).to include(event.title)
    fill_in("ticket_title", with: "General Admission")
    fill_in("ticket_price", with: 25.00)
    fill_in("ticket_qty_available", with: "foo")
    click_on("create_button")
    expect(current_path).to eq(event_tickets_path(event))
    expect(page.text).to include("Qty available is not a number")
  end


  it "should show details of a ticket" do
    visit event_tickets_path(event, key: event.event_guid)
    expect(page.text).to include("VIP")
    click_on("ticket_detail")
    expect(current_path).to eq(event_ticket_path(vip_ticket.event, vip_ticket))
    expect(page.text).to include("Total Available Tickets")
    expect(page.text).to include("Onsale Start")
  end

  it "should edit a ticket" do
    visit event_tickets_path(event, key: event.event_guid)
    expect(page.text).to include("VIP")
    click_on("ticket_edit")
    expect(current_path).to eq(edit_event_ticket_path(vip_ticket.event, vip_ticket))
    expect(page.text).to include("Edit Ticket")
    fill_in("ticket_price", with: 45.00)
    click_on("edit_button")
    expect(page.text).to include("$45.00")
    expect(current_path).to eq(event_tickets_path(vip_ticket.event))
  end

  it "should not edit a ticket with errors" do
    visit event_tickets_path(event, key: event.event_guid)
    expect(page.text).to include("VIP")
    click_on("ticket_edit")
    expect(current_path).to eq(edit_event_ticket_path(vip_ticket.event, vip_ticket))
    expect(page.text).to include("Edit Ticket")
    fill_in("ticket_price", with: "foo")
    click_on("edit_button")
    expect(page.text).to include("Price is not a number")
  end

  it "should redirect to root path with invalid event key - index" do
    visit event_tickets_path(event, key: "foo")
    expect(current_path).to eq(root_path)
  end

  it "should redirect to root path with invalid event key - show" do
    visit event_ticket_path(event, vip_ticket, key: "foo")
    expect(current_path).to eq(root_path)
  end

  it "should redirect to root path with invalid event key - edit" do
    visit edit_event_ticket_path(event, vip_ticket, key: "foo")
    expect(current_path).to eq(root_path)
  end

  it "should redirect to root path with invalid event key - new" do
    visit new_event_ticket_path(event, vip_ticket, key: "foo")
    expect(current_path).to eq(root_path)
  end
end
