# frozen_string_literal: true

require('pg')
require('pry')
require_relative('../db/sql_runner.rb')
require_relative('customer.rb')
require_relative('film.rb')
require_relative('screenings.rb')

class Ticket
  attr_accessor :customer_id, :film_id
  attr_reader :id

  def initialize(options)
    @customer_id = options['customer_id']
    @film_id = options['film_id']
    @hour = options['hour']
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = 'INSERT INTO tickets (customer_id,film_id,hour) VALUES ($1,$2, $3) RETURNING id'
    values = [@customer_id, @film_id, @hour]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def delete
    sql = 'DELETE FROM tickets WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = 'UPDATE tickets SET (customer_id,film_id) = ($1,$2,$3) WHERE id = $4'
    values = [@customer_id, @film_id,@hour, @id]
    SqlRunner.run(sql, values)
  end

  def find_screening_by_hour
    sql = 'SELECT * FROM screenings WHERE hour = $1'
    values = [@hour]
    results = SqlRunner.run(sql,values)[0]
    return Screening.new(results)
  end

  def find_customer_by_id
    sql = 'SELECT * FROM customers WHERE id = $1'
    values = [@customer_id]
    results = SqlRunner.run(sql,values)
    return Customer.map_all(results)[0]
  end

  def find_film_by_id
    sql = 'SELECT * FROM films WHERE id = $1'
    values = [@film_id]
    results = SqlRunner.run(sql,values)
    return Film.map_all(results)[0]
  end

  #BASIC EXTENSION TICKET BUY
  def buy_ticket
    customer = find_customer_by_id()
    film = find_film_by_id()
    screening = find_screening_by_hour()
    return 'sorry, but there is no space in the room' if screening.tickets_avalible < 1 
    customer.funds -= film.price
    customer.tickets_bougth += 1
    screening.tickets_avalible -= 1
    screening.update()
    customer.update()
  end

  def self.all
    sql = 'SELECT * from tickets'
    result = SqlRunner.run(sql)
    return Ticket.map_all(result)
  end

  def self.delete_all
    sql = 'DELETE FROM tickets'
    SqlRunner.run(sql)
  end

  def self.map_all(results)
    return results.map{|result| Ticket.new(result)}
  end
end
