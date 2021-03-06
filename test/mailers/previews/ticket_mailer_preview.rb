# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/ticket_mailer
class TicketMailerPreview < ActionMailer::Preview
  def ticket_email
    TicketMailer.with(ticket_details: PurchasedTicket.last(1), order_amount: 0, event: PurchasedTicket.last.event, order: Order.last).ticket_email
  end
end
