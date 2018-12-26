class OrdersController < ApplicationController

  before_action :logged_in_user
  before_action :set_event, only: [:show, :customer_order, :guest_list]

  def index
    @event = Event.where(id: params[:event_id], event_guid: params[:key]).first
    if @event
      authorized?(@event)
      @orders = Order.where(event_id: @event.id).reverse
    end     
  end 

  def show
    if @event
      authorized?(@event)
      @orders = Order.where(order_ref: params[:id])
    end 
  end 

  def customer_order
    if @event
      @orders = Order.where(user_id: current_user.id, event_id: params[:event_id])
      if @orders
        render template: 'orders/show'
      else
        redirect_to root_path
      end 
    else 
      redirect_to root_path
    end 
  end 

  def set_event
    @event = Event.find_by(id: params[:event_id])
  end 

  def guest_list
    if @event
      @purchased_tickets = PurchasedTicket.includes(:user).where(event_id: @event.id).order('users.name')
      if @purchased_tickets
        render template: 'orders/guest_list'
      else
        redirect_to root_path
      end 
    else 
      redirect_to root_path
    end
  end 
end 
