class OrdersController < ApplicationController

  before_action :logged_in_user

  def index
    @event = Event.where(id: params[:event_id], event_guid: params[:key]).first
    if @event
      authorized?(@event)
      @orders = Order.where(event_id: @event.id).reverse
    end     
  end 

  def show
    @event = Event.find(params[:event_id])
    if @event
      authorized?(@event)
      @order = Order.where(order_ref: params[:id]).first
      @tickets = PurchasedTicket.find(@order.purchased_ticket_ids)
    end 
  end 

  def customer_order
    # Add template so it can handle multiple orders
    @event = Event.where(id: params[:event_id]).first
    if @event
      @order = Order.where(user_id: current_user.id, event_id: params[:event_id]).first
      if @order
        @tickets = PurchasedTicket.where(id: @order.purchased_ticket_ids)
        render template: 'orders/show'
      else
        redirect_to root_path
      end 
    else 
      redirect_to root_path
    end 
    
  end 

end 
