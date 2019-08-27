# frozen-string-literal: true

require "sinatra"
require "sinatra/reloader"

@@number = rand(1..100)
@@color = "red"

get "/" do
  guess = params["guess"].to_i
  message = check_guess(guess)
  erb :index, locals: { number: @@number, message: message, color: @@color }
end

def check_guess(guess)
  case guess
  when 0
    start
  when (@@number + 6)..100
    way_too_high
  when 1..(@@number - 6)
    way_too_low
  when (@@number + 1)..100
    too_high
  when 1..(@@number - 1)
    too_low
  when @@number
    correct_guess
  end
end

def start
  @@color = "red"
  "Guess a number from 1 to 100!"
end

def way_too_high
  @@color = "red"
  "Way too high!"
end

def way_too_low
  @@color = "red"
  "Way too low!"
end

def too_high
  @@color = "tomato"
  "Too high!"
end

def too_low
  @@color = "tomato"
  "Too low!"
end

def correct_guess
  @@color = "lightgreen"
  "You got it!\n\nThe SECRET NUMBER is #{@@number}"
end
