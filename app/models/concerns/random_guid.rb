# frozen_string_literal: true

module RandomGuid
  extend ActiveSupport::Concern

  def create_guid
    guid = (1..6).map { (("A".."Z").to_a + ("0".."9").to_a)[rand(36)] }.join
    guid
  end
end
