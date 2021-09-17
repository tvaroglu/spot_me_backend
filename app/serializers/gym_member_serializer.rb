class GymMemberSerializer
  include JSONAPI::Serializer

  attributes :user_id, :gym_id
end
