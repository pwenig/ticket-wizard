# frozen_string_literal: true

class TicketsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @event = Event.where(id: params[:event_id], event_guid: params[:key]).first
    if @event
      @tickets = @event.tickets
    else
      redirect_to root_path
    end
  end

  def new
    @event = Event.where(id: params[:event_id], event_guid: params[:key]).first
    if @event
      @ticket = Ticket.new
    else
      redirect_to root_path
    end
  end

  def create
    @event = Event.find(params[:event_id])
    @ticket = Ticket.create(ticket_params)
    @ticket.event_id = params[:event_id].to_i
    if @ticket.save
      flash[:success] = "Ticket Created"
      redirect_to event_tickets_path(params[:event_id], key: @event.event_guid)
    else
      render :new
    end
  end

  def edit
    @event = Event.where(id: params[:event_id], event_guid: params[:key]).first
    if @event
      @ticket = Ticket.find(params[:id])
      authorized?(@ticket.event)
    else
      redirect_to root_path
    end
  end

  def update
    @event = Event.find(params[:event_id])
    @ticket = Ticket.find(params[:id])
    authorized?(@ticket.event)
    if @ticket.update(ticket_params)
      flash[:success] = "Ticket Updated!"
      redirect_to event_tickets_path(params[:event_id], key: @event.event_guid)
    else
      render :edit
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    authorized?(@ticket)
    @ticket.destroy
    flash[:success] = "Ticket Deleted"
    redirect_to event_tickets_path(params[:event_id], key: params[:key])
  end

  private

    def ticket_params
      params.require(:ticket).permit(:title, :description, :price, :qty_available, :onsale_start, :onsale_end)
    end
end
