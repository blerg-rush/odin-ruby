# frozen_string_literal: true

require "sinatra"
require "sinatra/reloader" if development?
require "./caesar_cipher"

enable :sessions

get "/" do
  @message = session.delete(:message)
  erb :index
end

post "/" do
  @string = params["string"]
  @offset = params["offset"]
  session[:message] = "Your encoded text: #{cipher(@string, @offset)}"
  redirect "/"
end
