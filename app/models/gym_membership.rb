class GymMembership < ApplicationRecord
  belongs_to :user

  has_many :events, dependent: :destroy

  validates :user_id, presence: true, numericality: true
  validates :yelp_gym_id, presence: true
  validates :gym_name, presence: true
end
