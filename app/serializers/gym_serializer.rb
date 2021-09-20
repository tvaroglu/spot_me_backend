class GymSerializer
  def self.format_gyms(gyms)
    {
      data:
        gyms.map do |gym|
          {
            id: gym.yelp_gym_id,
            type: 'gym',
            attributes: {
              name: gym.name,
              address: gym.address,
              phone: gym.phone
            }
          }
        end
    }
  end
end
