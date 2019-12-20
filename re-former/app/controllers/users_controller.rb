class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # @user = User.new(username: params[:username], email: params[:email],
    #                  password: params[:password])

    @user = User.new(username: params[:user][:username],
                     email: params[:user][:email],
                     password: params[:user][:password])

    if @user.save
      redirect_to new_user_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash.notice = "Successfully edited #{@user.name}"
      redirect_to edit_user_path
    else
      flash.notice = "Error: #{@user.errors.messages}"
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end