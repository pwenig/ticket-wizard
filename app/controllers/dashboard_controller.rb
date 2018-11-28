class DashboardController < ApplicationController

  def index
    @event = Event.where(id: params[:event_id], event_guid: params[:key]).first
    
  end
end 