class GymMembership < ApplicationRecord
  belongs_to :user

  has_many :events

  validates :user_id, presence: true, numericality: true
  validates :yelp_gym_id, presence: true
end
