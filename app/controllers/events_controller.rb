class EventsController < ApplicationController
  def index
    @events = Event.all.paginate(page: params[:page])
  end

  def new
    @event = Event.new
  end

  def create
    @current_user = current_user
    @event = @current_user.hosted_events.build(event_params)
    if @event.save
      flash[:success] = "Event created"
      redirect_to @event
    else
      flash.now[:danger] = @event.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @current_user = current_user
    @invitation = Invitation.find_or_create_by(event: @event, attendee: @current_user)
  end

  private

    def event_params
      params.require(:event).permit(:title, :date)
    end
end
