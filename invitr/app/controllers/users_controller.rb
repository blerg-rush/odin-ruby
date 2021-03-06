class UsersController < ApplicationController
  def index
    @users = User.all.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account created"
      login(@user)
      redirect_to @user
    else
      flash.now[:danger] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @user = params[:id].nil? ? current_user : User.find(params[:id])
    @upcoming_events = @user.hosted_events.upcoming
    @past_events = @user.hosted_events.past.first(3)
    @invitations = @user.invitations
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
