module SessionsHelper

  # Logs in a user
  def login(user)
    session[:user_id] = user.id
  end

  # Gets user by ID in session cookie
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end
end
