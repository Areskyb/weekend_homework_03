# frozen_string_literal: true

require('pg')
require('pry')
require_relative('../db/sql_runner.rb')
require_relative('film.rb')

class Customer
  attr_accessor :name, :funds, :tickets_bougth
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @funds = options['funds'].to_i
    @id = options['id'].to_i if options['id']
    @tickets_bougth = options['tickets_bougth'].to_i
  end

  def save
    sql = 'INSERT INTO customers (name,funds, tickets_bougth) VALUES ($1,$2,$3) RETURNING id'
    values = [@name, @funds, @tickets_bougth]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  # DELETE
  def delete
    sql = 'DELETE FROM customers WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # UPDATE
  def update
    sql = 'UPDATE customers SET (name,funds, tickets_bougth) = ($1,$2,$3) WHERE id = $4'
    values = [@name, @funds, @tickets_bougth, @id]
    SqlRunner.run(sql, values)
  end

  def films_watched
    sql = 'SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE customer_id = $1'
    values = [@id]
    results = SqlRunner.run(sql, values)
    Film.map_all(results)
  end

  # Another way of counting tickets :)
  def how_many_tickets
    sql = 'SELECT COUNT(customer_id) FROM tickets WHERE customer_id = $1'
    values = [@id]
    SqlRunner.run(sql, values)[0]['count'].to_i
  end

  # READ
  def self.all
    sql = 'SELECT * from customers'
    result = SqlRunner.run(sql)
    Customer.map_all(result)
  end

  # DELETE
  def self.delete_all
    sql = 'DELETE FROM customers'
    SqlRunner.run(sql)
  end

  def self.map_all(results)
    results.map { |result| Customer.new(result) }
  end
end
