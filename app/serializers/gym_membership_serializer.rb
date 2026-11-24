class GymMembershipSerializer
  include JSONAPI::Serializer

  attributes :user_id, :yelp_gym_id, :gym_name

  meta do |gym_membership|
    {
      # address: gym.respond_to?(:address) ? gym.address : nil,
      address: gym_membership.address,
      # address_details: gym.respond_to?(:address_details) ? gym.address_details : nil
      address_details: gym_membership.address_details
    }
  end
end
