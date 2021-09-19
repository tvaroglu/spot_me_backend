class GymFacade
  class << self
    # TODO: Perhaps we could use a guard clause instead of the if statement
    #
    # Example:
    #   return some_error_message unless gyms[:businesses]
    #
    #   gyms[:businesses].map { |gym| Gym.new(gym) }
    def query_yelp(location)
      gyms = GymService.get_gyms(location)

      if gyms[:businesses]
        gyms[:businesses].map { |gym| Gym.new(gym) }
      end
    end
  end
end
