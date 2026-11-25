class Api::V1::Users::GymMembershipsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    gym_memberships = GymMembership.where(user: user)

    render json: GymMembershipSerializer.new(gym_memberships).serializable_hash,
           status: :ok
  end

  def create
    user = User.find(params[:user_id])
    attributes = gym_membership_params

    begin
      gym_membership = user.gym_memberships.find_or_create_by!(
        yelp_gym_id: attributes[:yelp_gym_id]
      ) do |membership|
        membership.gym_name = attributes[:gym_name]
      end
    rescue ActiveRecord::RecordNotUnique => e
      Rails.logger.warn(
        "Duplicate gym membership creation attempt for user #{user.id}, " \
        "gym #{attributes[:yelp_gym_id]}: #{e.class}"
      )

      gym_membership = user.gym_memberships.find_by!(
        yelp_gym_id: attributes[:yelp_gym_id]
      )
    end

    render json: GymMembershipSerializer.new(gym_membership).serializable_hash,
           status: gym_membership.saved_change_to_id? ? :created : :ok
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
