class SuggestionsController < ApplicationController
  before_action :set_suggestion, only: %i[destroy edit update]
  before_action :set_event, only: %i[new edit update create]

  def new
    @suggestion = @event.suggestions.build
  end

  def create
    @suggestion = suggestion.new(suggestion_params)
    @suggestion.event_id = @event.id
    @suggestion.user_id = current_user.id
    if @suggestion.save!
      redirect_to event_path(@event)
    else
      render :new, :unprocessable_entity
    end
  end

  def edit; end

  def update
    @event = @suggestion.event
    @suggestion.user_id = current_user.id
    @suggestion.available = true
    if @suggestion.update!(suggestion_params)
      redirect_to event_path(@event), notice: "Got it!"
    else
      render :new, :unprocessable_entity
    end
  end

  def destroy
    if @suggestion.destroy
      redirect_to event_path(@event)
    else
      render :see_other, unprocessable_entity, notice: "suggestion can't be cancelled"
    end
  end

  private

  def suggestion_params
    params.require(:suggestion).permit(:date, :votes, :event_id, :user_id, :available)
  end

  def set_suggestion
    # @suggestion = suggestion.find(params[:id])
    @suggestion = @event.suggestions.find(params[:id])

  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
