class AnswersController < ApplicationController
  before_action :set_suggestion, only: %i[new create destroy]

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id
    @answer.suggestion_id = @suggestion.id
    unless @answer.save!
      render :new, :unprocessable_entity
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    # @answer = Answer.find_by(suggestion_id: params[:suggestion_id], id: params[:id])
    @answer.destroy!
    # render :see_other, :unprocessable_entity, notice: "Answer can't be canceled"
    # end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_suggestion
    @suggestion = Suggestion.find(params[:suggestion_id])
  end

  def answer_params
    params.require(:answer).permit(:suggestion_id, :user_id, :available)
  end
end
