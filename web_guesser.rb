# frozen-string-literal: true

require "sinatra"
require "sinatra/reloader"

@@number = rand(1..100)
@@color = "red"
@@guesses = 5

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
  use_guess("Way too high!")
end

def way_too_low
  @@color = "red"
  use_guess("Way too low!")
end

def too_high
  @@color = "tomato"
  use_guess("Too high!")
end

def too_low
  @@color = "tomato"
  use_guess("Too low!")
end

def correct_guess
  @@color = "lightgreen"
  win
end

def use_guess(result)
  @@guesses -= 1
  if @@guesses.zero?
    lose
  else
    "#{result} You have #{@@guesses} guesses left."
  end
end

def reset
  @@number = rand(1..100)
  @@guesses = 5
end

def lose
  old_number = @@number
  @@color = "crimson"
  reset
  "You lose<br><br>
    The SECRET NUMBER was #{old_number}<br><br>
    Thinking of a new number—try again!"
end

def win
  old_number = @@number
  reset
  "You got it!<br><br>
    The SECRET NUMBER is #{old_number}<br><br>
    Thinking of a new number—try again!"
end