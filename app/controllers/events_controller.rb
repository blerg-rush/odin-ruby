class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    user = current_user
    @event = user.hosted_events.build(event_params)
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
  end

  private

    def event_params
      params.require(:event).permit(:title, :date)
    end
end
