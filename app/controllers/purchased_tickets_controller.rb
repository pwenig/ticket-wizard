class PurchasedTicketsController < ApplicationController

  def new
    @event = Event.where(id: params[:event_id], event_guid: params[:key]).first
    if @event
      @purchased_ticket = PurchasedTicket.new
    else
      redirect_to root_path
    end
  end

  def create

  end 

end 