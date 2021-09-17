class GymMemberSerializer
  include JSONAPI::Serializer

  attributes :user_id, :gym_id
  #
  # belongs_to :gym
  # belongs_to :user
end
