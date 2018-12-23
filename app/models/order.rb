class Order < ActiveRecord::Base
  include RandomGuid

  belongs_to :user
  belongs_to :event
  # belongs_to :purchased_ticket

  def self.create_order(order_amount, ticket_details)
    order = Order.new
    order.user_id = ticket_details[:user].id
    order.amount = order_amount
    guid = order.create_guid
    order.order_ref = guid
    order.event_id = ticket_details[:event].id
    order
  end 

end 