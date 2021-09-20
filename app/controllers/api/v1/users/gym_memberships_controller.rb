class Api::V1::Users::GymMembershipsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    gym_memberships = GymMembership.where(user: user)

    render json: GymMembershipSerializer.new(gym_memberships).serializable_hash,
           status: :ok
  end
end
