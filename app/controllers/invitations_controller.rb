class InvitationsController < ApplicationController
  before_action :set_event
  def new
    @invitation = @event.invitations.build
  end

  def create
    user_ids = Array(params[:invitation][:usernames])
    user_ids.each do |username|
      invitation = @event.invitations.build(username: username)
      invitation.save
    end
    redirect_to event_path(@event), notice: 'Friends successfully invited'
  end

  private

  def invitation_params
    # params.require(:invitation).permit(:username, :event_id, :participate?)
    params.require(:invitation).permit(usernames: [])

  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end
end
