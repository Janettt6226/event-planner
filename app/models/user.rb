class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :invitations, dependent: :destroy
  has_many :events, through: :invitations
  has_many :slots
  has_many :events, through: :slots

  validates :username, uniqueness: true
end
