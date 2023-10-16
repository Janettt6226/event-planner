class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :suggestion
  validates :user_id, uniqueness: { scope: :suggestion_id, message: "has already replied to this suggestion" }
end
