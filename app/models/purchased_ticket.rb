# frozen_string_literal: true

class PurchasedTicket < ActiveRecord::Base

  include RandomGuid

  has_one_attached :barcode
  belongs_to :user
  belongs_to :event
  belongs_to :ticket
  validates :user_id, presence: true
  validates :event_id, presence: true
  validates :ticket_id, presence: true
  validates :ticket_guid, presence: true

  def self.create_ticket(ticket_details, order_amount)
    tickets = []
    order = Order.create_order(order_amount, ticket_details)
    ticket_details[:tickets].each do |ticket|
      ticket_id = ticket.keys.first.split("_").last.to_i
      ticket.values.first.to_i.times do |t|
        purchased_ticket = PurchasedTicket.new
        guid = purchased_ticket.create_guid
        purchased_ticket = PurchasedTicket.create!(event_id: ticket_details[:event].id, ticket_id: ticket_id, user_id: ticket_details[:user].id, ticket_guid: guid)
        tickets << purchased_ticket
      end
    end
    order.save!
    TicketMailer.with(ticket_details: tickets, order_amount: order_amount, event: ticket_details[:event], order: order ).ticket_email.deliver_now
  end
end
