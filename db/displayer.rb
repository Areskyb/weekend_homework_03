# frozen_string_literal: true

require('pry')

require_relative('../models/customer.rb')
require_relative('../models/film.rb')
require_relative('../models/ticket.rb')
require_relative('../models/screenings.rb')


def who_you_are
  p 'Hi, who are you? => admin/client'
  q = gets.chomp
  if q == 'admin'
    return admin_mode
  elsif q == 'client'
    return client_mode
  else
    p 'sorry you have to be explicit'
    who_you_are
  end
end

def client_mode
  p 'Welcome to your favourite cinema!! type to go => /films/buy_ticket/'
  e = gets.chomp
  if e == 'films'
  display_movies()
    end
  end

def admin_mode
  p 'type to go => /films/screenings/customers/films/tickets/'
  w = gets.chomp
end

def display_buy_tickets
  p "What film would you like to see?"
  display_movies()
  result = gets.chomp
end

def display_movies
  p 'Movies'
  for film in Film.all
    print film.title
    print ' =>'
    p film.display_hours
end
client_mode()
end


who_you_are()
