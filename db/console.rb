# frozen_string_literal: true

require('pry')

require_relative('../models/customer.rb')
require_relative('../models/film.rb')
require_relative('../models/ticket.rb')

Ticket.delete_all
Customer.delete_all
Film.delete_all


customer1 = Customer.new(
  'name' => 'Aresky',
  'funds' => 69
)

customer2 = Customer.new(
  'name' => 'Richard',
  'funds' => 69
)
customer3 = Customer.new(
  'name' => 'Yousheph',
  'funds' => 69
)

film1 = Film.new(
  'title' => 'Avatar',
  'price' => 6
)

film2 = Film.new(
  'title' => 'it',
  'price' => 9
)

film3 = Film.new(
  'title' => 'Primer',
  'price' => 3
)


customer1.save
customer2.save
customer3.save

film1.save
film2.save
film3.save

ticket1 = Ticket.new('customer_id' => customer1.id, 'film_id' => film1.id)
ticket2 = Ticket.new('customer_id' => customer1.id, 'film_id' => film2.id)
ticket3 = Ticket.new('customer_id' => customer2.id, 'film_id' => film2.id)
ticket4 = Ticket.new('customer_id' => customer3.id, 'film_id' => film3.id)
ticket5 = Ticket.new('customer_id' => customer1.id, 'film_id' => film3.id)

ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save


binding.pry
nil
