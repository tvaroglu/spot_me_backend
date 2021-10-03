class GymMembership < ApplicationRecord
  belongs_to :user

  has_many :events, dependent: :destroy

  validates :user_id, presence: true, numericality: true
  validates :yelp_gym_id, presence: true
  validates :gym_name, presence: true

  def find_gym
    GymFacade.find_gym(yelp_gym_id)
  end

  def address
    find_gym.address
  end

  def address_details
    find_gym.address_details
  end
end
