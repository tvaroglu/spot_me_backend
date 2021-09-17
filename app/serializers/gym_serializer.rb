class GymSerializer
  include JSONAPI::Serializer

  attributes :yelp_gym_id
  #
  # has_many :events
  # has_many :gym_members
end
