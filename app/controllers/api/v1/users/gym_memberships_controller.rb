class Api::V1::Users::GymMembershipsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    gym_memberships = GymMembership.where(user: user)

    render json: GymMembershipSerializer.new(gym_memberships).serializable_hash,
           status: :ok
  end

  def create
    user = User.find(params[:user_id])
    gym_membership = user.gym_memberships.create!(gym_membership_params)

    render json: GymMembershipSerializer.new(gym_membership).serializable_hash,
           status: :created
  end

  def destroy
    User.find(params[:user_id])
    gym_membership = GymMembership.find(params[:id])

    gym_membership.destroy!
  end

  private

  def gym_membership_params
    params.permit(:yelp_gym_id, :gym_name)
  end
end
