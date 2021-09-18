# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.
class Api::V1::Users::Gyms::GymMembersController < ApplicationController
  def create
    user = User.find(params[:user_id])
    gym = Gym.find(params[:gym_id])
    gym_member = GymMember.create!(user: user, gym: gym)

    render json: GymMemberSerializer.new(gym_member).serializable_hash,
           status: :created
  end
end
