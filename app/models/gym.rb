class Gym < ApplicationRecord
  validates :yelp_gym_id, presence: true
end
