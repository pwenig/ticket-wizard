require "rails_helper"

RSpec.describe Dashboard, type: :model do
  let(:category1) { create(:category) }
  let(:user) { create(:user) }
  let!(:event) { create(:event, date: "#{Time.now + 2.week.to_i}", category_id: category1.id) }
  let(:ticket) { create(:ticket, title: "VIP", price: 100, event_id: event.id) }
  let(:ticket2) { create(:ticket, title: "GA", price: 250, event_id: event.id) }

  before do
    FactoryBot.create_list(:purchased_ticket, 10, user_id: user.id, event_id: event.id, ticket_id: ticket.id )
    FactoryBot.create(:order, amount: 1000, purchased_ticket_ids: [PurchasedTicket.last(10).pluck(:id)], event: event, user: user)
    FactoryBot.create_list(:purchased_ticket, 10, user_id: user.id, event_id: event.id, ticket_id: ticket2.id )
    FactoryBot.create(:order, amount: 2500, purchased_ticket_ids: [PurchasedTicket.last(10).pluck(:id)], event: event, user: user)
  end

  it "calculates the ticket sales volume for an event by calling #calculate_volume" do 
    result = Dashboard.calculate_volume(event)
    expect(result).to eq(3500)
  end 

  it "calculates the number of tikcets sold for an event by calling #calculate_tickets_sold" do
    result = Dashboard.calculate_tickets_sold(event)
    expect(result).to eq(20)
  end

  it "returns a hash with ticket type and qty sold by calling #calculate_ticket_types" do 
    result = Dashboard.calculate_ticket_types(event)
    expect(result.class).to eq(Hash)
    expect(result["VIP"]).to eq(10)
    expect(result["GA"]).to eq(10)
  end 
end 