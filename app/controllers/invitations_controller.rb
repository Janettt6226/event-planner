class InvitationsController < ApplicationController
  before_action :set_invitation, only: %i[edit update]
  before_action :set_event, only: %i[new create edit update]

  def index
    @invitations = Invitation.all
    @user_invitations = @invitations.select { |invitation| invitation.user == current_user && invitation.participate? == false }
    @invitations_grouped_by_date = @user_invitations.group_by { |invitation| invitation.event.start_time.to_date }
    # CODE DUPPLIQUE events#index
    @invitations.each do |invitation|
      @participants = []
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
    Invitation.create(
      user_id: current_user.id,
      username: current_user.username,
      event_id: @event.id,
      participate: true
    )
    redirect_to event_path(@event), notice: 'Friends successfully invited'
  end

  def edit; end

  def update
    @invitation[:participate] === true
    if @invitation.update!(invitation_params)
      puts "Invitation Updated Successfully: #{@invitation.inspect}"
    else
      # render :see_other, :unprocessable_entity
      puts "Invitation Update Failed: #{@invitation.errors.full_messages.join(', ')}"
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:event_id, :participate, usernames: [])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_invitation
    # @invitation = @event.invitations.find(params[:id])
    @invitation = Invitation.find(params[:id])
  end
end
