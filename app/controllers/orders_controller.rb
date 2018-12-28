class OrdersController < ApplicationController

  before_action :logged_in_user
  before_action :set_event, only: [:show, :customer_order, :guest_list, :add_guest, :new_guest]

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

  def add_guest
    if @event
      @purchased_ticket = PurchasedTicket.new
      render template: 'orders/guest_order'
    else
      redirect_to root_path
    end 
  end 

  def new_guest
    if @event
      ticket_details = {
          user: create_user,
          event: @event,
          tickets: create_tickets
        }
      PurchasedTicket.create_ticket(ticket_details, 0)
      flash[:success] = "Guest added"
      redirect_to event_orders_path(@event, key: @event.event_guid)
    else 
      redirect_to root_path
    end 
  end 

  def create_user
    user = User.new
    user.name = params[:guest][:name]
    user.email = params[:guest][:email]
    user.save(:validate => false)
    user
  end 

  def create_tickets
    purchased_tickets = []
    tickets = @event.tickets
    tickets.each do |ticket|
      if params["ticket_id_#{ticket.id}"] != "0"
        purchased_tickets << params.to_unsafe_h.slice("ticket_id_#{ticket.id}")
      end
    end
    purchased_tickets
  end

  def set_event
    @event = Event.find_by(id: params[:event_id])
  end 
end 
