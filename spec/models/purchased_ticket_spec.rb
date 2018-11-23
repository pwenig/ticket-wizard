# frozen_string_literal: true

require "rails_helper"

RSpec.describe PurchasedTicket, type: :model do
  let(:category1) { create(:category) }
  let(:user) { create(:user) }
  let(:event) { create(:event, title: "Folk Festival", date: "#{Time.now + 2.week.to_i}", category_id: category1.id, user_id: user.id) }
  let(:ticket) { create(:ticket, title: "VIP", price: 100, event_id: event.id) }
  let(:purchased_ticket) { create(:purchased_ticket, user_id: user.id, event_id: event.id, ticket_id: ticket.id) }

  it "belongs to an event" do
    should belong_to(:event)
  end

  it "belongs to a usert" do
    should belong_to(:user)
  end

  it "belongs to a ticket" do
    should belong_to(:ticket)
  end

  it "should validate :user_id required" do
    should validate_presence_of(:user_id)
  end

  it "should validate :event_id required" do
    should validate_presence_of(:event_id)
  end

  it "should validate :ticket_id required" do
    should validate_presence_of(:ticket_id)
  end

  it "should create a purchased ticket" do
    regex = /^[a-zA-Z0-9]{0,8}$/
    expect(purchased_ticket.event.title).to eq("Folk Festival")
    expect(purchased_ticket.ticket.price).to eq(100)
    expect(purchased_ticket.ticket_guid).to match(regex)
    expect(purchased_ticket.user.name).to eq(user.name)
    expect(purchased_ticket.redeemed).to eq(false)
  end

  it "should create a purchased ticket by calling #create_ticket" do
    tickets = [{ "ticket_id_#{ticket.id}" => "1" }]
    ticket_details = {
        user: user,
        event: event,
        tickets: tickets
      }
    PurchasedTicket.create_ticket(ticket_details, 0)
    result = PurchasedTicket.last
    expect(result.event.title).to eq(event.title)
    FileUtils.rm_rf(Rails.root.join("tmp", "storage"))
  end

  # it "should return a file for the qrcode by calling #create_qr_code" do
  #   purchased_ticket = PurchasedTicket.new
  #   guid = purchased_ticket.create_guid
  #   result = PurchasedTicket.create_qr_code(guid)
  #   expect(result).to eq("./public/temp/#{guid}.png")
  #   File.delete(result)
  # end
end
