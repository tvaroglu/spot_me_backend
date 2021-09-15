class GymMember < ApplicationRecord
  belongs_to :gym
  belongs_to :user

  validates :user_id, presence: true, numericality: true
  validates :gym_id, presence: true, numericality: true
end
