require "rails_helper"

RSpec.describe "Event Order Pages", type: :feature do
  let!(:user) { create(:user) }
  let(:category1) { create(:category) }
  let!(:user2) { create(:user) }
  let!(:event) { create(:event, title: "Folk Festival", date: "#{Time.now + 4.day.to_i}", category_id: category1.id, user_id: user.id) }
  let(:ticket) { create(:ticket, title: "VIP", price: 100, event_id: event.id) }
  let(:purchased_ticket) { create(:purchased_ticket, user_id: user2.id, event_id: event.id, ticket_id: ticket.id)}
  let!(:order) { create(:order, user_id: user2.id, event_id: event.id, purchased_ticket_ids: [purchased_ticket.id])}

  describe "Authorized User" do 
    before do 
      sign_in_user(user)
      visit event_orders_path(event, key: event.event_guid)
    end 

    it "renders the event orders page" do 
      expect(page.text).to include "#{event.title} Orders"
    end 

    it 'renders the order show page' do 
      click_on 'Details'
      expect(page.text).to include "Order: #{order.order_ref}"
      expect(page.text).to include event.title
      expect(page.text).to include ticket.title
    end 

    it 'renders the event guest list' do 
      expect(page.text).to include 'View / Print Guest List'
      click_on 'View / Print Guest List'
      expect(page.text).to include "#{event.title} Guest List"
      expect(page.text).to include purchased_ticket.user.name
      expect(page.text).to include 'Print List'
    end 
  end 

  describe 'Authorized Customer' do 
    before do 
      sign_in_user(user2)
      visit event_user_order_path(event)
    end 

    it 'renders the customer order show page' do 
      expect(page.text).to include "Order: #{order.order_ref}"
      expect(page.text).to include event.title
      expect(page.text).to include ticket.title
    end 
  end 

  describe 'Invalid Event' do 
    before do 
      sign_in_user(user2)
      visit event_user_order_path(5)
    end 

    it 'redirects to root path' do 
      expect(page.text).to_not include "Order: #{order.order_ref}"
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