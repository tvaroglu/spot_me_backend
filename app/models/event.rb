class Event < ApplicationRecord
  belongs_to :user

  has_many :invitations, dependent: :destroy
  has_many :users, through: :invitations

  validates :user_id, presence: true, numericality: true
  validates :yelp_gym_id, presence: true
  validates :date_time, presence: true
  validates :activity, presence: true
end
