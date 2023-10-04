class InvitationsController < ApplicationController
  before_action :set_event, only: %i[edit update]

  def index
    @invitations = Invitation.all
    @invitations_grouped_by_date = @invitations.group_by { |invitation| invitation.event.start_time.to_date }
    # CODE DUPPLIQUE events#index
    @participants = []
    @invitations.each do |invitation|
      @participants << invitation.username if invitation.participate?
    end
  end

  def new
    @invitation = @event.invitations.build
  end

  def create
    usernames = Array(params[:invitation][:usernames])
    usernames.each do |username|
      invitation = @event.invitations.build(username: username)
      invitation.save
    end
    redirect_to event_path(@event), notice: 'Friends successfully invited'
  end

  def edit; end

  def update
    @invitation[:participate?] = true
    @invitation.update(invitation_params)
  end

  private

  def invitation_params
    params.require(:invitation).permit(usernames: [],  :event_id, :participate?)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end
end
