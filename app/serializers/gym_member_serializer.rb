class GymMemberSerializer
  include JSONAPI::Serializer

  attributes :user_id, :yelp_gym_id
end
