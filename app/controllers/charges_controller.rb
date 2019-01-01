# frozen_string_literal: true

class ChargesController < ApplicationController
  def new
  end

  def create
    event = Event.find(session[:event]["id"])
    Charge.set_user_keys(event.user)
    if session[:price] > 0
      begin
        amount = session[:price]
        customer = Stripe::Customer.create(
          email: params[:stripeEmail],
          source: params[:stripeToken]
        )
        charge = Stripe::Charge.create(
          customer: customer.id,
          amount: amount,
          description: "Tickets for #{event.title}",
          currency: "usd"
        )
        purchased_tickets = session[:purchased_tickets]
        ticket_details = {
          user: current_user,
          event: event,
          tickets: purchased_tickets
        }
        PurchasedTicket.create_ticket(ticket_details, session[:total_price])
        flash[:success] = "Thank you. Your tickets will be emailed shortly. You paid $#{session[:total_price]}."
        redirect_to user_path(current_user)
        clear_sessions
      rescue Stripe::AuthenticationError => ae
        flash[:error] = "There was an error with the Stripe settings #{ae}"
        redirect_to root_path
      rescue Stripe::CardError => e
        flash[:error] = "There was a problem with your credit card."
        redirect_to root_path
      rescue => exception
        flash[:error] = "There was an error #{exception}"
        redirect_to root_path
      else
      end
    else
      purchased_tickets = session[:purchased_tickets]
      ticket_details = {
        user: current_user,
        event: event,
        tickets: purchased_tickets
      }
      PurchasedTicket.create_ticket(ticket_details, session[:total_price])
      flash[:success] = "Thank you. Your tickets will be emailed shortly."
      redirect_to user_path(current_user)
      clear_sessions
    end
  end

  def calculate
    prices = []
    amounts = []
    purchased_tickets = []
    @event = Event.find(params[:event_id])
    tickets = @event.tickets
    tickets.each do |ticket|
      if params["ticket_id_#{ticket.id}"] != "0"
        purchased_tickets << params.to_unsafe_h.slice("ticket_id_#{ticket.id}")
        amounts << params["ticket_id_#{ticket.id}"].to_i
        prices << (params["ticket_id_#{ticket.id}"].to_i * ticket.price).to_i
      end
    end
    session[:purchased_tickets] = purchased_tickets
    @total_price = prices.inject(0, :+)
    @total_tickets = amounts.inject(0, :+)
    if @total_tickets == 0
      redirect_to new_event_purchased_ticket_path(@event, key: @event.event_guid)
    else
      amounts.inject(0, :+) > 1 ? @ticket = "tickets" : @ticket = "ticket"
      session[:total_price] = @total_price
      session[:price] = (prices.inject(0, :+)) * 100
      session[:event] = @event
      render :new
    end
  end

  def clear_sessions
    session.delete(:price)
    session.delete(:total_price)
    session.delete(:event)
    session.delete(:purchased_tickets)
  end
end
