class Invitation < ApplicationRecord
  belongs_to :user, foreign_key: "username", primary_key: "username"
  belongs_to :event
  validates :username, uniqueness: { scope: :event_id, message: "has already been invited to this event" }
  validates :event_id, presence: true
  attr_accessor :usernames
end
