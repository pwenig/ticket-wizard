require "rails_helper"

RSpec.describe Order, type: :model do
  let(:category1) { create(:category) }
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:event) { create(:event, title: "Folk Festival", date: "#{Time.now + 2.week.to_i}", category_id: category1.id) }
  let(:ticket) { create(:ticket, title: "VIP", price: 100, event_id: event.id) }
  let!(:purchased_ticket) { create(:purchased_ticket, user_id: user2.id, event_id: event.id, ticket_id: ticket.id) }

  it "should belong to a user" do 
    should belong_to(:user)
  end 

  it "should belong to an event" do 
    should belong_to(:event)
  end 

  it "should create an order" do 
    order = FactoryBot.create(:order, user: user2, event: event, purchased_ticket_ids: [purchased_ticket.id])
    expect(order.purchased_ticket_ids.first).to eq(purchased_ticket.id)
  end 
end 