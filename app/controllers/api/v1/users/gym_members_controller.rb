# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.
class Api::V1::Users::GymMembersController < ApplicationController
  def index
    return error_message if params[:yelp_gym_id].blank?

    user = User.find(params[:user_id])
    users = user.non_followees_at_same_gym(params[:yelp_gym_id])

    render json: UserSerializer.new(users).serializable_hash, status: :ok
  end

  private

  def error_message
    render(
      json: {
        message: 'your query could not be completed',
        errors: ['must provide yelp_gym_id to retrieve members at this gym']
      },
      status: :not_found
    )
  end
end
