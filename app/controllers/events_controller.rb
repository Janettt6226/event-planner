class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Event.all
    @events_grouped_by_date = @events.group_by { |event| event.start_time.to_date }
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
    params.require(:event).permit(:start_time, :title, :description, :location)
  end

  def set_event
    @event = Event.find(params[:id])
  end

end
