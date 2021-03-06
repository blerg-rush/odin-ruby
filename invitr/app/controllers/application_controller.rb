class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  attr_writer :current_user
  helper_method :logged_in?, :current_user

  def login(user)
    new_token = User.new_token
    cookies.permanent[:remember_token] = new_token
    user.update_attribute(:remember_digest, User.digest(new_token))
    @current_user = user
  end

  def logout
    user = current_user
    cookies.delete :remember_token
    user.update_attribute(:remember_digest, nil)
    @current_user = nil
  end

  def current_user
    remember_digest = User.digest(cookies.permanent[:remember_token])
    @current_user ||= User.find_by(remember_digest: remember_digest)
  end

  def logged_in
    return if logged_in?

    flash[:warning] = "Please log in or create an account"
    redirect_to login_path
  end

  private

    def logged_in?
      !current_user.nil?
    end
end
