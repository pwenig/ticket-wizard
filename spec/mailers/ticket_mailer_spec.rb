require "rails_helper"

RSpec.describe TicketMailer, :type => :mailer do
  describe "ticket_email" do
    let(:category1) { create(:category) }
    let(:user) { create(:user) }
    let(:event) { create(:event, title: "Folk Festival", date: "#{Time.now + 2.week.to_i}", category_id: category1.id, user_id: user.id) }
    let(:ticket) { create(:ticket, title: "VIP", price: 100, event_id: event.id) }
    let(:purchased_ticket) { create(:purchased_ticket, user_id: user.id, event_id: event.id, ticket_id: ticket.id) }
    let(:mail) { TicketMailer.with(ticket_details: [purchased_ticket], order_amount: ticket.price).ticket_email }

    it "renders the headers" do
      expect(mail.subject).to eq("Your Tickets")
      expect(mail.from).to eq(["tickets@ticket-ninja.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end
end