class Invitation < ApplicationRecord
  belongs_to :user, foreign_key: "username", primary_key: "username"
  belongs_to :event
  validates :username, :event_id, presence: true
  # validates :user_id, presence: true, uniqueness: true
  attr_accessor :usernames
end
