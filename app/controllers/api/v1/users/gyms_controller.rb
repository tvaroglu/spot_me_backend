# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers
class Api::V1::Users::GymsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    gyms = user.gyms

    render json: GymSerializer.new(gyms).serializable_hash, status: :ok
  end

  def destroy
    user = User.find(params[:user_id])
    gym = Gym.find(params[:id])
    gym_member = GymMember.find_by(user: user, gym: gym)

    return gym_member.destroy! if gym_member.present?

    render json: {:message=>"your query could not be completed",
                  :errors=>[gym_member_not_found_message]},
           status: :not_found
  end

  private

  def gym_member_not_found_message
    "Couldn't find Gym with 'id'=#{params[:id]} where User is a member"
  end
end
