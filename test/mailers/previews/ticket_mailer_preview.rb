# Preview all emails at http://localhost:3000/rails/mailers/ticket_mailer
class TicketMailerPreview < ActionMailer::Preview

  def ticket_email
    TicketMailer.with(ticket_details: PurchasedTicket.last(2), order_amount: 0).ticket_email
  end


end
