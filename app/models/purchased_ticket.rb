# frozen_string_literal: true

class PurchasedTicket < ActiveRecord::Base
  require "rqrcode"

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
    ticket_details[:tickets].each do |ticket|
      ticket_id = ticket.keys.first.split("_").last.to_i
      ticket.values.first.to_i.times do |t|
        purchased_ticket = PurchasedTicket.new
        guid = purchased_ticket.create_guid
        # Get this working as an attached pdf
        # barcode_file = create_qr_code(guid)
        purchased_ticket = PurchasedTicket.create!(event_id: ticket_details[:event].id, ticket_id: ticket_id, user_id: user = ticket_details[:user].id, ticket_guid: guid)
        # purchased_ticket.barcode.attach(io: File.open(barcode_file), filename: "#{guid}.png", content_type: 'image/png')
        tickets << purchased_ticket
        # File.delete(barcode_file)
      end
    end
    TicketMailer.with(ticket_details: tickets, order_amount: order_amount).ticket_email.deliver_now
  end

  # def self.create_qr_code(guid)
  #   qrcode = RQRCode::QRCode.new(guid)
  #   png = qrcode.as_png(
  #     resize_gte_to: false,
  #     resize_exactly_to: false,
  #     fill: "white",
  #     color: "black",
  #     size: 120,
  #     border_modules: 4,
  #     module_px_size: 6,
  #     file: nil # path to write
  #     )
  #   barcode_file = png.save("./public/temp/#{guid}.png", interlace: true)
  #   barcode_file.path
  # end
end
