class InvitationsController < ApplicationController
  def new
    @event = Event.find_by(id: params[:format])
    @users = User.where.not(id: @event.attendees.ids).where.not(id: @event.host.id)
    @invitation = Invitation.new(event: @event)
  end

  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.save
      flash[:success] = "Invitation sent!"
      @event = @invitation.event
      redirect_to @event
    else
      flash.now[:danger] = @invitation.errors.full_messages.to_sentence
    end
  end

  def accept
    invitation = Invitation.find(params[:id])

    if invitation.accept!
      flash[:success] = "You have accepted the invitation!"
    else
      flash[:danger] = "You cannot accept this invitation"
    end
    redirect_to(invitation.event)
  end

  def decline
    invitation = Invitation.find(params[:id])

    if invitation.decline!
      flash[:success] = "You have declined the invitation."
    else
      flash[:danger] = "You cannot decline this invitation."
    end
    redirect_to(invitation.event)
  end

  private

    def invitation_params
      params.require(:invitation).permit(:attendee_id, :event_id, :status)
    end
end
