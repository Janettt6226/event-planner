class SlotsController < ApplicationController
  before_action :set_slot, only: %i[show destroy edit update]
  before_action :set_event, only: %i[edit update create]

  def show; end

  def new
    @slot = Slot.new
  end

  def create
    @slot = Slot.new(slot_params)
    @slot.event_id = @event.id
    if @slot.save
      redirect_to event_path(@event)
    else
      render :new, unprocessable_entity
    end
  end

  def edit; end

  def update
    @slot.votes += 1
    @slot.update(slot_params)
  end


  def destroy
    if @slot.destroy
      redirect_to event_path(@event)
    else
      render :see_other, unprocessable_entity, notice: "Slot can't be cancelled"
    end
  end

  private

  def slot_params
    params.require(:slot).permit(:date, :votes, :event_id)
  end

  def set_slot
    @slot = Slot.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
