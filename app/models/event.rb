class Event < ApplicationRecord
  has_many :user_to_events
  has_many :users, through: :user_to_events
  VISIBILITY = %w[public private].freeze
end
