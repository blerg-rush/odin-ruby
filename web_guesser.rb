# frozen-string-literal: true

require "sinatra"
require "sinatra/reloader"

@@number = rand(1..100)

get "/" do
  guess = params["guess"].to_i
  message = check_guess(guess)
  erb :index, locals: { number: @@number, message: message }
end

def check_guess(guess)
  case guess
  when 0
    "Guess a number from 1 to 100!"
  when (@@number + 6)..100
    "Way too high!"
  when 1..(@@number - 6)
    "Way too low!"
  when (@@number + 1)..100
    "Too high!"
  when 1..(@@number - 1)
    "Too low!"
  when @@number
    "You got it!\n\nThe SECRET NUMBER is #{@@number}"
  end
end
