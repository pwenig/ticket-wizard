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

  before_create :generate_guid

  def generate_guid
    self.ticket_guid = create_guid
  end
end
