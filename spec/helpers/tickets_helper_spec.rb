require "rails_helper"

RSpec.describe TicketsHelper, type: :helper do
  let(:category1) { create(:category) }
  let(:user) { create(:user) }
  let!(:event) { create(:event, title: "Folk Festival", date: "#{Time.now + 2.week.to_i}", category_id: category1.id, user_id: user.id) }
  let!(:ticket1) { create(:ticket, title: "VIP", event_id: event.id, qty_available: 1) }
  let!(:ticket2) { create(:ticket, title: "GA", onsale_start: Time.now + 1.week.to_i,  event_id: event.id, qty_available: 1) }


  describe '#show_action?' do
    it 'returns true' do 
      result = helper.show_action?(event)
      expect(result).to be(true)
    end   
  end 
end 