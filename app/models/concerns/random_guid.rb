# frozen_string_literal: true

module RandomGuid
  extend ActiveSupport::Concern

  def create_guid
    guid = SecureRandom.base64.delete("/+=")[0, 8]
    guid
  end
end
