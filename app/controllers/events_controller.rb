# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :store_location, only: [:show]

  def index
    @categories = Category.all
    if params[:category]
      @events =  Event.search(params).paginate(page: params[:page], per_page: 12)
    else
      @created_events = Event.user_created_events(current_user).paginate(page: params[:page], per_page: 12)
      @events = Event.user_events(current_user).paginate(page: params[:page], per_page: 12)
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    @event.category_id = params[:category_id].to_i
    if @event.save && @event.has_valid_date?
      current_user.attend(@event)
      flash[:success] = "Event Created"
      redirect_to new_event_ticket_path(@event, key: @event.event_guid)
    else
      render :new
    end
  end

  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def show
    @event = Event.where(id: params[:id], event_guid: params[:key]).first
    if @event
      @category = Category.find(@event.category_id).name
      @comments = @event.comments
      @comment = Comment.new
    else
      redirect_to root_path
    end
  end

  def edit
    @event = Event.where(id: params[:id], event_guid: params[:key]).first
    if @event
      authorized?(@event)
    else
      redirect_to root_path
    end
  end

  def update
    @event = Event.find(params[:id])
    authorized?(@event)
    @event.category_id = params[:category_id].to_i
    if @event.update(event_params) && @event.has_valid_date?
      flash[:success] = "Event Updated!"
      redirect_to event_path(@event, key: @event.event_guid)
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    authorized?(@event)
    @event.destroy
    flash[:success] = "Event Deleted"
    redirect_to current_user
  end

private
  def event_params
    params.require(:event).permit(:title, :description, :date, :category_id, :picture, :address, :latitude, :longitude)
  end
end
