# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ticket, type: :model do
  let(:category1) { create(:category) }
  let(:user) { create(:user) }
  let(:event) { create(:event, title: "Folk Festival", date: "#{Time.now + 2.week.to_i}", category_id: category1.id, user_id: user.id) }
  let(:ticket) { create(:ticket, title: "VIP", user_id: user.id, event_id: event.id) }

  it "creates a ticket" do
    expect(ticket.title).to eq("VIP")
  end

  it "belongs to a user" do
    should belong_to(:user)
  end

  it "belongs to an event" do
    should belong_to(:event)
  end

  it "returns true if tickets are on-sale" do
    result = ticket.onsale?
    expect(result).to eq(true)
  end

  it "returns false if tickets are not on-sale" do
    ticket2 =  create(:ticket, title: "VIP", onsale_start: "#{Time.now + 2.week.to_i}", user_id: user.id, event_id: event.id)
    result = ticket2.onsale?
    expect(result).to eq(false)
  end

  it "returns true if tickets are off-sale" do
    ticket2 =  create(:ticket, title: "VIP", onsale_end: "#{Time.now - 2.week.to_i}", user_id: user.id, event_id: event.id)
    result = ticket2.offsale?
    expect(result).to eq(true)
  end

  it "calls #generate_guid before_create" do
    regex = /^[a-zA-Z0-9]{0,6}$/
    expect(ticket.ticket_guid).to match(regex)
  end
end
