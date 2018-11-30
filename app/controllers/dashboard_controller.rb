class DashboardController < ApplicationController
  include ActionView::Helpers::DateHelper

  def index
    @event = Event.where(id: params[:event_id], event_guid: params[:key]).first
    @event_sales_volume = calculate_volume(@event)
    @event_tickets = calculate_tickets_sold(@event)
    @event_time_remaining = helpers.distance_of_time_in_words_to_now(@event.date)
    @ticket_types = calculate_ticket_types(@event)
    @tickets_by_day = PurchasedTicket.where(event_id: @event.id).group_by_day(:created_at).count
  end

  private

  def calculate_volume(event)
    PurchasedTicket.where(event_id: event.id).map{|x| x.ticket}.map{|c| c.price}.inject(0){|sum,x| sum + x }
  end
  
  def calculate_tickets_sold(event)
    PurchasedTicket.where(event_id: event.id).length
  end 

  def calculate_ticket_types(event)
    tickets_purchased = PurchasedTicket.where(event_id: event.id).map{|x| x.ticket}.group_by{|x| x.title}
    tickets_purchased.map { |key, value| [key, value.length] }.to_h
  end 


end 