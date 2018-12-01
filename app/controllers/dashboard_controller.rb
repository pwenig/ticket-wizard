class DashboardController < ApplicationController
  include ActionView::Helpers::DateHelper

  before_action :logged_in_user

  def index
    @event = Event.where(id: params[:event_id], event_guid: params[:key]).first
    if @event
      authorized?(@event)
      @event_sales_volume = Dashboard.calculate_volume(@event)
      @event_tickets = Dashboard.calculate_tickets_sold(@event)
      @event_time_remaining = helpers.distance_of_time_in_words_to_now(@event.date)
      @ticket_types = Dashboard.calculate_ticket_types(@event)
      @tickets_by_day = PurchasedTicket.where(event_id: @event.id).group_by_day(:created_at).count
    else 
      redirect_to root_path
    end 
  end
end 