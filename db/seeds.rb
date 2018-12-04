
Category.create(name: "Arts")
Category.create(name: "Business")
Category.create(name: "Charity")
Category.create(name: "Education")
Category.create(name: "Fashion")
Category.create(name: "Film & Media")
Category.create(name: "Food & Drink")
Category.create(name: "Health")
Category.create(name: "Hobbies")
Category.create(name: "Holiday")
Category.create(name: "Music")
Category.create(name: "Science & Tech")
Category.create(name: "Spirituality")
Category.create(name: "Sports & Fitness")
Category.create(name: "Travel & Outdoor")
Category.create(name: "Other")
admin = User.create!(name: 'Paul Wenig', email: 'pwenig@gmail.com', password: 'password', password_confirmation: 'password', admin: true)
user2 = User.create!(name: 'Joe Customer', email: 'pwenig+10@gmail.com', password: 'password', password_confirmation: 'password')
user3 = User.create!(name: 'Mary Customer', email: 'pwenig+20@gmail.com', password: 'password', password_confirmation: 'password')
event = Event.create!(title: 'Rock Concert', description: 'Rock Concert', address: '1400 Pearl St, Boulder, CO',  date: "#{Time.now + 4.day.to_i}", category_id: Category.first.id, user_id: admin.id)
ticket = Ticket.create!(title: "VIP", price: 100, event_id: event.id)
ticket2 = Ticket.create!(title: "GA", price: 50, event_id: event.id)

10.times do
  guid = SecureRandom.base64.delete("/+=")[0, 8]
  purchased_ticket = PurchasedTicket.create!(user_id: user2.id, event_id: event.id, ticket_id: ticket.id, ticket_guid: guid, created_at: "#{Time.now - 4.day.to_i}")
  guid2 = SecureRandom.base64.delete("/+=")[0, 8]
  Order.create(user_id: user2.id, event_id: event.id, amount: purchased_ticket.ticket.price, order_ref: guid2, purchased_ticket_ids: [purchased_ticket.id])
end
8.times do
  guid = SecureRandom.base64.delete("/+=")[0, 8]
  purchased_ticket_2 = PurchasedTicket.create!(user_id: user3.id, event_id: event.id, ticket_id: ticket2.id, ticket_guid: guid, created_at: "#{Time.now - 10.day.to_i}")
  guid3 = SecureRandom.base64.delete("/+=")[0, 8]
  Order.create(user_id: user3.id, event_id: event.id, amount: purchased_ticket_2.ticket.price, order_ref: guid3, purchased_ticket_ids: [purchased_ticket_2.id])
end 


