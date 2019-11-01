# frozen_string_literal: true

require('pg')
require('pry')
require_relative('../db/sql_runner.rb')
require_relative('film.rb')

class Customer
  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @funds = options['funds']
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = 'INSERT INTO customers (name,funds) VALUES ($1,$2) RETURNING id'
    values = [@name, @funds]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def delete
    sql = 'DELETE FROM customers WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = 'UPDATE customers SET (name,funds) = ($1,$2) WHERE id = $3'
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def films_watched
      sql = 'SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE customer_id = $1'
      values = [@id]
      results = SqlRunner.run(sql,values)
      return Film.map_all(results)
  end

  def self.all
    sql = 'SELECT * from customers'
    result = SqlRunner.run(sql)
    return Customer.map_all(result)
  end

  def self.delete_all
    sql = 'DELETE FROM customers'
    SqlRunner.run(sql)
  end

  def self.map_all(results)
    return results.map{|result| Customer.new(result)}
  end
end
