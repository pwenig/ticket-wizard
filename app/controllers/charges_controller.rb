# frozen_string_literal: true

class ChargesController < ApplicationController

  def new
  end

  # http://localhost:3000/events/12?key=CbPXPkHE

  def create
    event = Event.find(session[:event]['id'])
    Charge.set_user_keys
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
      
      # Create the PurchasedTicket
      current_user.attend(event)
      # Send email with tickets

      flash[:success] = "Thank you. Your tickets will be emailed shortly. You paid $#{session[:total_amount]}."
      redirect_to user_path(current_user)
      clear_sessions
    rescue Stripe::AuthenticationError
      flash[:error] = "There was an error with the Stripe settings"
      redirect_to new_charge_path
    rescue Stripe::CardError => e
      flash[:error] = "There was a problem with your credit card."
      redirect_to new_charge_path
    rescue => exception
      flash[:error] = "There was an error"
      redirect_to new_charge_path
    else
    end
  end

  def calculate
    prices = []
    amounts = []
    @event = Event.find(params[:event_id])
    tickets = @event.tickets
    tickets.each do |ticket|
      if params["ticket_id_#{ticket.id}"] != "0"
        amounts << params["ticket_id_#{ticket.id}"].to_i
        prices << (params["ticket_id_#{ticket.id}"].to_i * ticket.price).to_i
      end
    end
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
  end
end
