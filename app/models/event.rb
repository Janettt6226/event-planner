class Event < ApplicationRecord
  has_many :invitations, dependent: :destroy
  has_many :users, through: :invitations
  has_many :suggestions, dependent: :destroy
  has_many :users, through: :suggestions

  VISIBILITY = %w[public private].freeze
end
