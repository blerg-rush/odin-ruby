class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      flash[:success] = "Alright, come in. Quickly!"
      redirect_to root_url # TODO: Send to posts index
    else
      flash.now[:danger] = "You're not on the list. Get lost!"
      render :new
    end
  end

  def destroy
  end
end
