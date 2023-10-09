class InvitationsController < ApplicationController
  before_action :set_event, only: %i[new create edit update]
  before_action :set_invitation, only: %i[edit update]

  def index
    @invitations = Invitation.all
    @user_invitations = @invitations.select { |invitation| invitation.username = current_user.username }
    @invitations_grouped_by_date = @user_invitations.group_by { |invitation| invitation.event.start_time.to_date }
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
    params.require(:invitation).permit(:event_id, :participate?, usernames: [])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_invitation
    @invitation = @event.invitations.find(params[:id])
    # @invitation = Invitation.find(params[:id])
  end
end
