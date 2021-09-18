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

  def destroy
    user = User.find(params[:user_id])
    gym = Gym.find(params[:gym_id])
    gym_member = GymMember.find_by(user: user, gym: gym)

    return gym_member.destroy! if gym_member.present?

    render json: error_gym_member_not_found,
           status: :bad_request
  end

  private

  def error_gym_member_not_found
    {:message=>"your query could not be completed",
     :errors=>["User with 'id'=#{params[:user_id]} is not "\
               "a member of Gym with 'id'=#{params[:gym_id]}"]}
  end
end
