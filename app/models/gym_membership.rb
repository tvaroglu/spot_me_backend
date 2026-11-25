class GymMembership < ApplicationRecord
  belongs_to :user

  has_many :events, dependent: :destroy

  validates :user_id, presence: true, numericality: true
  validates :yelp_gym_id, presence: true
  validates :gym_name, presence: true

  def address
    find_gym&.address
  end

  def address_details
    find_gym&.address_details || {}
  end

  def find_gym
    return @find_gym if defined?(@find_gym)

    gym = GymFacade.find_gym(yelp_gym_id)
    if gym.is_a?(Gym)
      @find_gym = gym
    else
      reason = gym.is_a?(Hash) ? gym.dig(:errors, :error) : gym.class.name
      Rails.logger.warn("Yelp lookup unavailable for gym #{yelp_gym_id}: #{reason}")
      @find_gym = nil
    end
  rescue Faraday::Error, JSON::ParserError => e
    Rails.logger.warn("Yelp lookup unavailable for gym #{yelp_gym_id}: #{e.class}")
    @find_gym = nil
  end

  def self.gym_member_count(yelp_gym_id)
    GymMembership.where(yelp_gym_id: yelp_gym_id).size
  end
end
