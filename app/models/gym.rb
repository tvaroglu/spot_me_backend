class Gym < ApplicationRecord
  has_many :events
  has_many :gym_members
  has_many :users, through: :gym_members

  validates :yelp_gym_id, presence: true
end
