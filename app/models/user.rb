class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :invitations, dependent: :destroy
  has_many :events, through: :invitations
  # has_many :events, through: :suggestions
  has_many :answers, dependent: :destroy
  has_many :suggestions, through: :answers
  validates :username, uniqueness: true
end
