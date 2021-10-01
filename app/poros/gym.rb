class Gym
  attr_reader :yelp_gym_id, :name, :address, :address_details, :phone

  def initialize(info)
    @name        = info[:name]
    @yelp_gym_id = info[:id]
    @address     = info[:location][:display_address].join(', ')
    @address_details = info[:location].except(:display_address, :cross_streets)
    @phone       = info[:display_phone]
  end
end
