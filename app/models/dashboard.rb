class Dashboard
  extend ActiveModel::Naming

  def self.calculate_volume(event)
    Order.where(event_id: event.id).map{|c| c.amount}.inject(0){|sum,c| sum + c }
  end

  def self.calculate_tickets_sold(event)
    PurchasedTicket.where(event_id: event.id).length
  end 

  def self.calculate_ticket_types(event)
    tickets_purchased = PurchasedTicket.where(event_id: event.id).map{|x| x.ticket}.group_by{|x| x.title}
    tickets_purchased.map { |key, value| [key, value.length] }.to_h
  end 
end 