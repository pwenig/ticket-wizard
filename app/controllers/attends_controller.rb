# frozen_string_literal: true

class AttendsController < ApplicationController
  before_action :logged_in_user

  def create
    @event = Event.find(params[:attended_event_id])
    if current_user.attend(@event)
      flash[:success] = "Confirmed. Enjoy #{@event.title} on #{@event.date.to_formatted_s(:long)}"
      redirect_to user_path(current_user)
    else 
      render :event
    end 
  end

  def destroy
    @event = Attend.find(params[:id]).attended_event
    if current_user.unattend(@event)
      flash[:success] = "Confirmed. You are no longer attending #{@event.title}"
      redirect_to user_path(current_user)
    else
      render :event
    end 
  end
end
