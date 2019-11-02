# frozen_string_literal: true

require('pry')

require_relative('../models/customer.rb')
require_relative('../models/film.rb')
require_relative('../models/ticket.rb')
require_relative('../models/screenings.rb')


Ticket.delete_all
Screening.delete_all
Customer.delete_all
Film.delete_all


customer1 = Customer.new(
  'name' => 'Aresky',
  'funds' => 69
)
customer1.save

customer2 = Customer.new(
  'name' => 'Richard',
  'funds' => 69
)
customer2.save

customer3 = Customer.new(
  'name' => 'Yousheph',
  'funds' => 69
)
customer3.save

film1 = Film.new(
  'title' => 'Avatar',
  'price' => 6
)
film1.save

film2 = Film.new(
  'title' => 'It',
  'price' => 9
)
film2.save

film3 = Film.new(
  'title' => 'Primer',
  'price' => 3
)
film3.save

screening1 = Screening.new('film_name' => film1.title, 'hour' => '21:00','tickets_avalible' => 50)
screening1.save
screening4 = Screening.new('film_name' => film1.title, 'hour' => '12:00','tickets_avalible' => 50)
screening4.save
screening2 = Screening.new('film_name' => film2.title, 'hour' => '19:00','tickets_avalible' => 50)
screening2.save
screening5 = Screening.new('film_name' => film2.title, 'hour' => '13:00','tickets_avalible' => 50)
screening5.save
screening3 = Screening.new('film_name' => film3.title, 'hour' => '16:00','tickets_avalible' => 35)
screening3.save
screening6 = Screening.new('film_name' => film3.title, 'hour' => '21:00','tickets_avalible' => 50)
screening6.save




ticket1 = Ticket.new('customer_id' => customer1.id, 'film_id' => film1.id, 'hour' => screening1.hour)
ticket1.save
ticket1.buy_ticket
ticket2 = Ticket.new('customer_id' => customer1.id, 'film_id' => film2.id, 'hour' => screening2.hour)
ticket2.save
ticket2.buy_ticket
ticket3 = Ticket.new('customer_id' => customer2.id, 'film_id' => film2.id, 'hour' => screening2.hour)
ticket3.save
ticket3.buy_ticket
ticket4 = Ticket.new('customer_id' => customer3.id, 'film_id' => film3.id, 'hour' => screening3.hour)
ticket4.save
ticket4.buy_ticket
ticket5 = Ticket.new('customer_id' => customer1.id, 'film_id' => film3.id, 'hour' => screening6.hour)
ticket5.save
ticket5.buy_ticket


binding.pry
nil
