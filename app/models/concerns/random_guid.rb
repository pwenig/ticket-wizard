# frozen_string_literal: true

module RandomGuid
  extend ActiveSupport::Concern

  def create_guid
    guid = SecureRandom.hex(4)
    guid
  end
end
