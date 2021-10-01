class GymFacade
  class << self
    def query_yelp(location)
      gyms = GymService.get_gyms(location)

      return unless gyms[:businesses]

      gyms[:businesses].map { |gym| Gym.new(gym) }
    end

    def find_gym(gym_id)
      return invalid_gym_id_length if gym_id.length != 22

      gym = GymService.find_gym(gym_id)
      if gym[:error].present?
        {
          errors: {
            error: gym[:error][:description],
            status: :not_found.to_s.tr('_', ' ').titleize,
            code: Rack::Utils::SYMBOL_TO_STATUS_CODE[:not_found]
          },
          code: :not_found
        }
      else
        Gym.new(gym)
      end
    end

    def invalid_gym_id_length
      {
        errors: {
          error: 'Invalid ID length',
          status: :bad_request.to_s.tr('_', ' ').titleize,
          code: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request]
        },
        code: :bad_request
      }
    end
  end
end
