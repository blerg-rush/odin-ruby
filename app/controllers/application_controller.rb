class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def login(user)
    new_token = User.new_token
    cookies.permanent[:remember_token] = new_token
    user.remember_digest = User.digest(new_token)
  end
end
