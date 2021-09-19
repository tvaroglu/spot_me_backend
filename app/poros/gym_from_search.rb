class GymFromSearch
  attr_reader :id, :yelp_gym_id, :name, :address, :phone

  def initialize(info)
    @id = nil
    @name = info[:name]
    @yelp_gym_id = info[:id]
    @address = info[:location][:display_address].join(', ')
    @phone = info[:display_phone]
  end
end
