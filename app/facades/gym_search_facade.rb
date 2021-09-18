class GymSearchFacade
  def self.query_yelp(location)
    gyms = YelpService.gyms_near_user(location)

    if gyms[:businesses]
      gyms[:businesses].map do |gym|
        GymFromSearch.new(gym)
      end
    end
  end
end
