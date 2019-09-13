class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      login @user
      flash[:success] = "Alright, come in. Quickly!"
      redirect_to root_url # TODO: Send to posts index
    else
      flash.now[:danger] = "You're not on the list. Get lost!"
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = "Remember, first rule about the clubhouse . . ."
    redirect_to root_url
  end
end
