class Event < ApplicationRecord
  has_many :invitations, dependent: :destroy
  has_many :users, through: :invitations
  has_many :slots, dependent: :destroy
  VISIBILITY = %w[public private].freeze
end
