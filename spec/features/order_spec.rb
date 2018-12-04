require "rails_helper"

RSpec.describe "Event Order Pages", type: :feature do
  let!(:user) { create(:user) }
  let(:category1) { create(:category) }
  let!(:user2) { create(:user) }
  let!(:event) { create(:event, title: "Folk Festival", date: "#{Time.now + 4.day.to_i}", category_id: category1.id, user_id: user.id) }
  let(:ticket) { create(:ticket, title: "VIP", price: 100, event_id: event.id) }

  before do
    FactoryBot.create_list(:purchased_ticket, 5, user_id: user2.id, event_id: event.id, ticket_id: ticket.id )
  end 

  describe "Authorized User" do 
    before do 
      sign_in_user(user)
      visit event_orders_path(event, key: event.event_guid)
    end 

    it "renders the event orders page" do 
      expect(text).to include "#{event.title} Orders"
    end 
    
  end 

  describe "Unauthorized User" do 
    before do 
      sign_in_user(user2)
      visit event_orders_path(event, key: event.event_guid)
    end 

    it "does renders the index page and redirects to root" do 
      expect(text).to_not include('Event Orders')
      expect(current_path).to eq '/'
    end 
  end 
end 