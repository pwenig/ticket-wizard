# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ticket, type: :model do
  let(:category1) { create(:category) }
  let(:user) { create(:user) }
  let(:event) { create(:event, title: "Folk Festival", date: "#{Time.now + 2.week.to_i}", category_id: category1.id, user_id: user.id) }
  let(:ticket) { create(:ticket, title: "VIP", event_id: event.id, qty_available: 1) }
  let(:ticket1) { create(:ticket, title: "GA", event_id: event.id, qty_available: 1) }
  let(:ticket2) { create(:ticket, title: "GA", event_id: event.id, qty_available: 4) }
  let!(:purchased_ticket) { create(:purchased_ticket, user_id: user.id, event_id: event.id, ticket_id: ticket.id) }
  let!(:purchased_ticket2) { create(:purchased_ticket, user_id: user.id, event_id: event.id, ticket_id: ticket2.id) }

  it "creates a ticket" do
    expect(ticket.title).to eq("VIP")
  end

  it "belongs to an event" do
    should belong_to(:event)
  end

  it "returns true if tickets are on-sale" do
    result = ticket.onsale?
    expect(result).to eq(true)
  end

  it "returns false if tickets are not on-sale" do
    ticket2 =  create(:ticket, title: "VIP", onsale_start: "#{Time.now + 2.week.to_i}", event_id: event.id)
    result = ticket2.onsale?
    expect(result).to eq(false)
  end

  it "returns true if tickets are off-sale" do
    ticket2 =  create(:ticket, title: "VIP", onsale_end: "#{Time.now - 2.week.to_i}", event_id: event.id)
    result = ticket2.offsale?
    expect(result).to eq(true)
  end

  it "returns true if tickets are sold out" do 
    result = ticket.soldout?
    expect(result).to eq(true)
  end 

  it 'returns true if no tickets have been sold' do 
    result = ticket1.tickets_not_sold?
    expect(result).to eq(true)
  end 

  it 'returns false if tickets have been sold' do 
    result = ticket.tickets_not_sold?
    expect(result).to eq(false)
  end 

  it "returns an error if qty_available it not a number" do
    ticket2 = build(:ticket, title: "VIP", qty_available: "foo", onsale_end: "#{Time.now - 2.week.to_i}", event_id: event.id)
    expect(ticket2).to_not be_valid
    expect(ticket2.errors.full_messages).to eq ["Qty available is not a number"]
  end

  it 'returns the number of availavble tickets if the available is less then 4' do 
    range = ticket2.ticket_qty_options
    expect(range).to eq((0..3))
  end 
end
