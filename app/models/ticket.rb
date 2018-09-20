# frozen_string_literal: true

class Ticket < ActiveRecord::Base
  include RandomGuid

  validates :title, presence: true
  validates :price, presence: true
  validates :price, numericality: { only_number: true }
  validate :qty_amount
  before_create :generate_guid
  belongs_to :user
  belongs_to :event

  def onsale?
    self.onsale_start < Time.now
  end

  def offsale?
    Time.now > self.onsale_end
  end

  def generate_guid
    self.ticket_guid = create_guid
  end

  def qty_amount
    if !self.qty_available.nil? && self.qty_available == 0
      errors.add(:qty_available, "is not a number")
    end
  end
end
