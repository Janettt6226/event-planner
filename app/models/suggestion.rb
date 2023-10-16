class Suggestion < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :users, through: :answers

  scope :ordered_by_answers, -> { includes(:answers).order(part_numerical_value: :desc).order("answers.user_id desc") }

end
