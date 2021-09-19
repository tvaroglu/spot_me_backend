class GymMember < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, numericality: true
  validates :yelp_gym_id, presence: true
end
