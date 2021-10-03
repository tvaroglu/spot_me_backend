class GymMembership < ApplicationRecord
  belongs_to :user

  has_many :events, dependent: :destroy

  delegate :address, to: :find_gym
  delegate :address_details, to: :find_gym

  validates :user_id, presence: true, numericality: true
  validates :yelp_gym_id, presence: true
  validates :gym_name, presence: true

  def find_gym
    GymFacade.find_gym(yelp_gym_id)
  end
end
