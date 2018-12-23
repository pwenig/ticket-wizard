# frozen_string_literal: true

class Ticket < ActiveRecord::Base
  validates :title, presence: true
  validates :price, presence: true
  validates :price, numericality: { only_number: true }
  validate :qty_amount
  belongs_to :event
  has_many :purchased_tickets, dependent: :destroy

  def onsale?
    onsale_start.nil? || onsale_start < Time.now
  end

  def offsale?
    !onsale_end.nil? && Time.now > onsale_end
  end

  def soldout?
    !qty_available.nil? && PurchasedTicket.where(ticket_id: id).length >= qty_available
  end 

  def tickets_not_sold?
    PurchasedTicket.where(ticket_id: id).length == 0
  end

  def qty_amount
    if !self.qty_available.nil? && self.qty_available == 0
      errors.add(:qty_available, "is not a number")
    end
  end

  # This method reuturns a range of ticket quantities for the select option.
  # If there are less then 4 tickets available, show the qty availaile.
  def ticket_qty_options
    ticket_options = (0..4)
    purchased_tickets = PurchasedTicket.where(ticket_id: id).length
    if qty_available
      available_tickets = qty_available.to_i - purchased_tickets
      if available_tickets < 4
        ticket_options = (0..available_tickets)
      end 
    end 
    ticket_options
  end 
end
