class GymSearchFacade
  class << self
    def query_yelp(location)
      gyms = YelpService.get_gyms(location)
      gyms[:businesses].map { |gym| GymFromSearch.new(gym) } if gyms[:businesses]
    end
  end
end
