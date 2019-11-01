# frozen_string_literal: true

require('pg')
require('pry')
require_relative('../db/sql_runner.rb')

class Ticket
  attr_accessor :customer_id, :film_id
  attr_reader :id

  def initialize(options)
    @customer_id = options['customer_id']
    @film_id = options['film_id']
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = 'INSERT INTO tickets (customer_id,film_id) VALUES ($1,$2) RETURNING id'
    values = [@customer_id, @film_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def delete
    sql = 'DELETE FROM tickets WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = 'UPDATE tickets SET (customer_id,film_id) = ($1,$2) WHERE id = $3'
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
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
