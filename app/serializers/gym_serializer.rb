class GymSerializer
  include JSONAPI::Serializer

  attributes :yelp_gym_id, :name
end