class Gym < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :gym_members, dependent: :destroy
  has_many :users, through: :gym_members

  validates :yelp_gym_id, presence: true
end
