class YelpService
  def self.connection_setup
    Faraday.new(url: 'https://api.yelp.com/') do |faraday|
      faraday.headers['Authorization'] = ENV['yelp_api_key']
    end
  end

  def self.gyms_near_user(location)
    response = connection_setup.get("v3/businesses/search?term=gyms&radius=40000&sort_by=distance&location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
