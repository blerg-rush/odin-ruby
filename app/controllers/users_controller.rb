class UsersController < ApplicationController
  def index
    @users = User.all.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(params[:name])
    if @user.save
      flash[:info] = "Account created"
      login(@user)
      redirect_to @user
    else
      flash.now[:danger] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @user = User.find_by(params[:name])
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
    end
end
