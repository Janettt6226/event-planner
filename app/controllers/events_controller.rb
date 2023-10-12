class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Event.all
    # ⬇ on collecte les invitations relatives à chaque event
    @invitations = @events.map(&:invitations).flatten
    # ⬇ on sélectionne celles auxquelles le user participe
    @user_accepted_invitations = @invitations.select { |invitation| invitation.user == current_user && invitation.participate? }
    # ⬇ on collecte les events relatifs aux invitations acceptées
    @user_events = @user_accepted_invitations.flatten.map(&:event)
    @events_grouped_by_date = @user_events.group_by { |event| event.start_time.to_date }

    # PARTICIPANTS
    @events.each do |event|
      @participants = []
      event.invitations.each do |invitation|
        @participants << invitation.username if invitation.participate? == true
      end
    end
  end

  def show
    @slots = @event.slots
    # @user = @slot.user&.
    @slot = @slots.build
    # @participants = @event.invitations.select { |slot| slot.available? == true }
  end

  def new
    @event = Event.new
    @invitation = @event.invitations.build
  end

  def create
    @event = Event.new(event_params)
    if @event.save!
      redirect_to new_event_invitation_path(@event)
    else
      render :new, :unprocessable_entity
    end
    Invitation.create(
      user_id: current_user.id,
      username: current_user.username,
      event_id: @event.id,
      participate: true
    )
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit, :unprocessable_entity
    end
  end

  def destroy
    if @event.destroy
      redirect_to events_path
    else
      render :see_other, :unprocessable_entity, notice: "Event can't be cancelled"
    end
  end

  private

  def event_params
    params.require(:event).permit(:start_time, :end_time, :title, :description, :location)
  end

  def set_event
    @event = Event.find(params[:id])
  end

end
