class InvitationsController < ApplicationController
  before_action :set_invitation, only: %i[edit update destroy]
  before_action :set_event, only: %i[new create edit update destroy]

  def index
    @invitations = Invitation.all
    @user_invitations = @invitations.select { |invitation| invitation.user == current_user && !invitation.participate? unless invitation.event.start_time.nil? }
    @invitations_grouped_by_date = @user_invitations.group_by { |invitation| invitation.event.start_time.to_date }
    # CODE DUPPLIQUE events#index
    @invitations.each do |invitation|
      @participants = []
      @participants << invitation.username if invitation.participate?
    end

    @answer = Answer.new
    @undefined_events = @user_invitations.select { |invitation| invitation.event.suggestions.present? }.map(&:event)
    @defined_events = @user_invitations.map(&:event) - @undefined_events

  end

  def new
    usernames = User.all.pluck(:username)
    @guests = usernames.reject { |user| user == current_user.username }
    invited_usernames = @event.invitations.pluck(:username)
    @uninvited_guests = @guests - invited_usernames
    # @uninvited_usernames = @uninvited_guests.zip(User.all.pluck(:username)).to_h
    @uninvited_usernames = @uninvited_guests
    @invitation = @event.invitations.build
  end

  def create
    puts "Usernames submitted: #{params[:invitation][:usernames]}"
    usernames = Array(params[:invitation][:usernames]).reject!(&:empty?)
    puts "Usernames submitted: #{usernames.inspect}"
    usernames.each do |username|
      invitation = @event.invitations.build(username: username)
      invitation.save!
    end
    redirect_to event_path(@event), notice: 'Friends successfully invited'
  end

  def edit; end

  def update
    @invitation.participate = true
    if @invitation.update!(invitation_params)
      puts "Invitation Updated Successfully: #{@invitation.inspect}"
    else
      # render :see_other, :unprocessable_entity
      puts "Invitation Update Failed: #{@invitation.errors.full_messages.join(', ')}"
    end
  end

  def destroy
    if @invitation.destroy!
      redirect_to user_invitations_path(current_user)
    else
      render :see_other, :unprocessable_entity
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
