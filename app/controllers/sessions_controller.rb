# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :already_logged_in?, only: [:new, :create]

  def new
  end

  def create
    binding.pry
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to session[:previous_url] || user
    else
      flash.now[:danger] = "Invalid Email or Password"
      render :new
    end
  end

  def destroy
    log_out
    session[:previous_url] = nil
    redirect_to root_path
  end
end
