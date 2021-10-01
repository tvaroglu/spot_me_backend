class GymSerializer
  class << self
    def format_gyms(gyms)
      {
        data: gyms.map do |gym|
          {
            id: gym.yelp_gym_id,
            type: 'gym',
            attributes: {
              name: gym.name,
              address: gym.address,
              address_details: gym.address_details,
              phone: gym.phone
            }
          }
        end
      }
    end

    def format_gym(gym)
      {
        data: {
          id: gym.yelp_gym_id,
          type: 'gym',
          attributes: {
            name: gym.name,
            address: gym.address,
            address_details: gym.address_details,
            phone: gym.phone
          }
        }
      }
    end
  end
end
