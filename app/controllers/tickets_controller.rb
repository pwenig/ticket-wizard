# frozen_string_literal: true

class TicketsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @event = Event.find(params[:event_id])
    @tickets = @event.tickets.paginate(page: params[:page], per_page: 12)
  end

  def new
    @event = Event.find(params[:event_id])
    @ticket = Ticket.new
  end

  def create
    @ticket = current_user.tickets.build(ticket_params)
    @ticket.event_id = params[:event_id].to_i
    if @ticket.save!
      flash[:success] = "Ticket Created"
      redirect_to event_tickets_path(params[:event_id])
    else
      flash.now[:danger] = "Onsale date must be ahead of today's date"
      render :new
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
    @ticket.onsale_start ? @days_remaining = (@ticket.onsale_end - @ticket.onsale_start).to_i / 86400 : 0
  end

  def edit
    @ticket = Ticket.find(params[:id])
    authorized?(@ticket.event)
  end

  def update
    @ticket = Ticket.find(params[:id])
    authorized?(@ticket.event)
    if @ticket.update(ticket_params)
      flash[:success] = "Ticket Updated!"
      redirect_to event_tickets_path
    else
      flash.now[:danger] = "Ticket Not Updated"
      redirect_to event_tickets_path
    end
  end

  # Add check to see if tickets have been sold
  def destroy
    @ticket = Ticket.find(params[:id])
    authorized?(@ticket)
    @ticket.destroy
    flash[:success] = "Ticket Deleted"
    redirect_to event_tickets_path
  end

  private

    def ticket_params
      params.require(:ticket).permit(:title, :description, :price, :qty_available, :onsale_start, :onsale_end)
    end
end
