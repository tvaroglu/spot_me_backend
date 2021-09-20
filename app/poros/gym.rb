class Gym
  attr_reader :yelp_gym_id, :name, :address, :phone

  def initialize(info)
    @name        = info[:name]
    @yelp_gym_id = info[:id]
    @address     = info[:location][:display_address].join(', ')
    @phone       = info[:display_phone]
  end
end
