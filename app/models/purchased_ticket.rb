# frozen_string_literal: true

class PurchasedTicket < ActiveRecord::Base
  require "rqrcode"

  include RandomGuid

  # has_one_attached :barcode
  belongs_to :user
  belongs_to :event
  belongs_to :ticket
  validates :user_id, presence: true
  validates :event_id, presence: true
  validates :ticket_id, presence: true
  validates :ticket_guid, presence: true

  def self.create_ticket(ticket_details)
    ticket_details[:tickets].each do |ticket|
      ticket_id = ticket.keys.first.split("_").last.to_i
      ticket.values.first.to_i.times do |t|
        purchased_ticket = PurchasedTicket.new
        guid = purchased_ticket.create_guid
        barcode_file_path = create_qr_code(guid)
        PurchasedTicket.create!(event_id: ticket_details[:event].id, ticket_id: ticket_id, user_id: user = ticket_details[:user].id, ticket_guid: guid, barcode: barcode_file_path)
      end
    end
  end

  def self.create_qr_code(guid)
    qrcode = RQRCode::QRCode.new(guid)
    png = qrcode.as_png(
      resize_gte_to: false,
      resize_exactly_to: false,
      fill: "white",
      color: "black",
      size: 120,
      border_modules: 4,
      module_px_size: 6,
      file: nil # path to write
      )
    file_path = "tmp/qrcodes/#{guid}.png"
    File.open(file_path, "wb") do |file|
      file.write(png.to_s)
    end
    file_path
  end
end
