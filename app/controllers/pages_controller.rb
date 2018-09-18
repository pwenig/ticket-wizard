# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    # Enable if we want to feature events nearby
    
    # # Test geocoding services locally by hardcoding latitude and longitude
    # if Rails.env.development? || Rails.env.test?
    #   visitor_latitude = 34.05223
    #   visitor_longitude = -118.24368
    # else
    #   visitor_latitude = request.location.latitude
    #   visitor_longitude = request.location.longitude
    # end
    @events = []
  end

  def about
  end
end
