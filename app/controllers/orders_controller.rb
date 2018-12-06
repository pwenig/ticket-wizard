class OrdersController < ApplicationController

  before_action :logged_in_user

  def index
    @event = Event.where(id: params[:event_id], event_guid: params[:key]).first
    if @event
      authorized?(@event)
      @orders = Order.where(event_id: @event.id)
    end     
  end 

  def show
    # Add specs
    @event = Event.where(params[:event_id])
    if @event
      authorized?(@event)
      @order = Order.where(order_ref: params[:id]).first
      @tickets = PurchasedTicket.find(@order.purchased_ticket_ids)
    end 
  end 

end 
