class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Event.all
    @confirmed_events = @events.reject { |event| event.start_time.nil? }
    # ⬇ on collecte les invitations relatives à chaque event
    @invitations = @confirmed_events.map(&:invitations).flatten
    # ⬇ on sélectionne celles auxquelles le user participe
    @user_accepted_invitations = @invitations.select { |invitation| invitation.user == current_user && invitation.participate? }
    # ⬇ on collecte les events relatifs aux invitations acceptées
    @user_events = @user_accepted_invitations.flatten.map(&:event)
    @events_grouped_by_date = @user_events.group_by { |event| event.start_time.to_date unless event.start_time.nil? }

    # PARTICIPANTS
    @events.each do |event|
      @participants = []
      event.invitations.each do |invitation|
        @participants << invitation.username if invitation.participate? == true
      end
    end
  end

  def show
    @suggestions = @event.suggestions
    @suggestion = Suggestion.new
    @answer = Answer.new(suggestion: @suggestion)
    # @answers = @suggestions.map(&:answers)
    # @user = @suggestion.user&.
    # @participants = @event.invitations.select { |suggestion| suggestion.available? == true }
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
    return if @event.start_time.nil? == false
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

  def calendar
    @events = Event.all
    @events_to_invitations = @events.map(&:invitations).flatten
    # ⬇ on sélectionne celles auxquelles le user participe
    @user_accepted_invitations = @events_to_invitations.select { |invitation| invitation.user == current_user && invitation.participate? }
    # ⬇ on collecte les events relatifs aux invitations acceptées
    @user_events = @user_accepted_invitations.flatten.map(&:event)

    # @invitations = Invitation.all
    # @user_invitations = @invitations.select { |invitation| invitation.user == current_user && !invitation.participate? }
    # @user_pending_events = @user_invitations.flatten.map(&:event)

    # @combined_items = @user_events + @user_pending_events

    start_date = params.fetch(:start_date, Date.today).to_date
    @events = Event.where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end

  private

  def event_params
    params.require(:event).permit(:start_time, :end_time, :title, :description, :location)
  end

  def set_event
    @event = Event.find(params[:id])
  end

end
