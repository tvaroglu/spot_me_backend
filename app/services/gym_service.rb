class GymService
  class << self
    def conn
      Faraday.new(url: 'https://api.yelp.com/') do |faraday|
        faraday.headers['Authorization'] = ENV['yelp_api_key']
      end
    end

    def params
      'term=gyms&radius=40000&sort_by=distance'
    end

    def get_gyms(location)
      JSON.parse(
        conn.get("v3/businesses/search?#{params}&location=#{location}").body,
        symbolize_names: true
      )
    end

    def find_gym(gym_id)
      JSON.parse(
        conn.get("v3/businesses/#{gym_id}").body,
        symbolize_names: true
      )
    end
  end
end
