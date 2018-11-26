# frozen_string_literal: true

module TicketsHelper

  def show_action?(event)
    onsale_dates = event.tickets.pluck(:onsale_start)
    if onsale_dates.include?(nil)
      return true
    else 
      onsale =  onsale_dates.map{ |x| !x.nil? && x < Time.now }
      onsale.include?(true)
    end 
  end 
end
