class GymMember < ApplicationRecord
  belongs_to :user
  belongs_to :gym

  validates :user_id, presence: true
  validates :gym_id, presence: true
end
