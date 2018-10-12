# frozen_string_literal: true

class TicketMailer < ApplicationMailer
  default from: "tickets@ticket-ninja.com"

  def ticket_email
    @user = params[:ticket_details].first.user
    @url  = "http://example.com/login"
    mail(to: @user.email, subject: "Your Tickets")
  end
end
