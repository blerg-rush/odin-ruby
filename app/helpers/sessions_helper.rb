module SessionsHelper

  # Logs in a user
  def login(user)
    session[:user_id] = user.id
  end
end
