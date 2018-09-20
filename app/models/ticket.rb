# frozen_string_literal: true

class Ticket < ActiveRecord::Base
  include RandomGuid

  validates_presence_of :title, length: { maximum: 100 }
  # work on validations
  validates_presence_of :price, numericality: true

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

end
