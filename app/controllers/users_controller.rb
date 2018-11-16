# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :already_logged_in?, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to session[:previous_url] || @user
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    authorized?(@user)
    @display_name = "#{@user.name}'s"
    if params[:timeline] == "Upcoming Events"
      @title = params[:timeline]
      @events = @user.upcoming_events.paginate(page: params[:page], per_page: 12)
    elsif params[:timeline] == "Past Events"
      @title = params[:timeline]
      @events = @user.past_events.paginate(page: params[:page], per_page: 12)
    else
      @display_name = "#{@user.name} is" if @display_name == "#{@user.name}'s"
      @title = "Events You're Attending"
      user_purchased_event_ids = PurchasedTicket.where(user_id: current_user.id).pluck(:event_id).uniq
      events = Event.where(id: user_purchased_event_ids)
      current_events = events.where("date > ?", Time.now)
      @events = current_events.paginate(page: params[:page], per_page: 12)
      @display_name = "#{@user.name}'s" if @display_name == "#{@user.name} is"
      @created_events = Event.user_created_events(@user).paginate(page: params[:page], per_page: 12)
    end
  end

  def edit
    @user = User.find(params[:id])
    authorized?(@user)
  end

  def update
    @user = User.find(params[:id])
    return if authorized?(@user)
    if @user.update(user_params)
      flash[:success] = "Updated Successfully"
      redirect_to @user
    else
      render :edit
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, 
      :stripe_publishable_key, :stripe_secret_key)
  end
end
