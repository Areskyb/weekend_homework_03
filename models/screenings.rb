require_relative('../db/sql_runner.rb')
require_relative('film.rb')

class Screening
attr_reader :id
attr_accessor :film_name, :hour, :tickets_avalible

def initialize(options)
  @film_name = options['film_name']
  @hour = options['hour']
  @tickets_avalible = options['tickets_avalible'].to_i
  @id = options['id'].to_i if options['id']
end

def save
  sql = 'INSERT INTO screenings (film_name,hour, tickets_avalible) VALUES ($1,$2,$3) RETURNING id'
  values = [@film_name, @hour, @tickets_avalible]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i
end

def update
  sql = 'UPDATE screenings SET (film_name,hour,tickets_avalible) = ($1,$2,$3) WHERE id = $4'
  values = [@film_name, @hour, @tickets_avalible, @id]
  SqlRunner.run(sql, values)
end

def self.delete_all
  sql = 'DELETE FROM screenings'
  SqlRunner.run(sql)
end
end
