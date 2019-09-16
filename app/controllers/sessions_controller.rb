class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:session][:name])
    if @user && @user.authenticate(params[:session][:password])
      login @user
      flash[:success] = "Logged in successfully"
      redirect_to @user
    else
      flash.now[:danger] = "Invalid username or password"
      render :new
    end
  end

  def destory
    logout
    flash[:success]
    redirect_to root_path
  end
end
