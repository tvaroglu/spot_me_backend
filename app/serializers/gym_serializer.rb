class Gym
  include JSONAPI::Serializer

  attributes :yelp_gym_id, :name, :address, :phone
end
