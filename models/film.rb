# frozen_string_literal: true

require('pg')
require('pry')
require_relative('../db/sql_runner.rb')
require_relative('screenings.rb')
require_relative('customer.rb')

class Film
  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @price = options['price'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = 'INSERT INTO films (title,price) VALUES ($1,$2) RETURNING id'
    values = [@title, @price]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def delete
    sql = 'DELETE FROM films WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = 'UPDATE films SET (title,price) = ($1,$2) WHERE id = $3'
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers_watch
      sql = 'SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE film_id = $1'
      values = [@id]
      results = SqlRunner.run(sql,values)
      return Customer.map_all(results)
  end
  #How many customers are going to watch the movie
  def how_many_customers
    sql = 'SELECT COUNT(film_id) FROM tickets WHERE film_id = $1'
    values = [@id]
    return SqlRunner.run(sql,values)[0]['count'].to_i
  end

  def display_hours
      sql = 'SELECT * FROM screenings WHERE film_name = $1'
      values = [@title]
      results = SqlRunner.run(sql,values)
      return results.map { |screening| Screening.new(screening).hour  }
  end


  def self.all
    sql = 'SELECT * from films'
    result = SqlRunner.run(sql)
    return Film.map_all(result)
  end

  def self.delete_all
    sql = 'DELETE FROM films'
    SqlRunner.run(sql)
  end

  def self.map_all(results)
    return results.map{|result| Film.new(result)}
  end
end
