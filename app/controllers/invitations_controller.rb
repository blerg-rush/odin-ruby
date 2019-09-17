class InvitationsController < ApplicationController
  # wrap_parameters :invitation, include: %i[attendee_id event_id status]

  def new
    @invitation = Invitation.new
    #@event = 
  end

  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.save
      flash[:success] = "Tell your friends!"
      @event = @invitation.event
      redirect_to @event
    else
      flash.now[:danger] = @invitation.errors.full_messages.to_sentence
    end
  end

  private

    def invitation_params
      params.require(:invitation).permit(:attendee_id, :event_id, :status)
    end
end
