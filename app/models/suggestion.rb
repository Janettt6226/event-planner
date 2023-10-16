class Suggestion < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :users, through: :answers
end
