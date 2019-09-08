class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # log in and go to user's profile
    else
      flash.now[:danger] = "Invalid user credentials"
      render :new
    end
  end

  def destroy
  end
end
