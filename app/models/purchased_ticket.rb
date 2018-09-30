# frozen_string_literal: true

class PurchasedTicket < ActiveRecord::Base
  include RandomGuid

  belongs_to :user
  belongs_to :event
  belongs_to :ticket
  validates :user_id, presence: true
  validates :event_id, presence: true
  validates :ticket_id, presence: true
  validates :ticket_guid, presence: true

  def self.create_ticket(ticket_details)
    ticket_details[:tickets].each do |ticket|
      ticket_id = ticket.keys.first.split('_').last.to_i
      ticket.values.first.to_i.times do |t|
        purchased_ticket = PurchasedTicket.new
        guid = purchased_ticket.create_guid
        PurchasedTicket.create!(event_id: ticket_details[:event].id, ticket_id: ticket_id, user_id: user = ticket_details[:user].id, ticket_guid: guid)
      end
    end 
  end 

end