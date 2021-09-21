# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.
class Api::V1::Users::GymMembersController < ApplicationController
  def index
    if params[:yelp_gym_id].blank?
      return render json: error_message, status: :not_found
    end

    user = User.find(params[:user_id])
    users = user.non_friends_at_same_gym(params[:yelp_gym_id]) if user

    render json: UserSerializer.new(users).serializable_hash, status: :ok
  end

  private

  def error_message
    {
      message: 'your query could not be completed',
      errors: ['must provide yelp_gym_id to retrieve current users at this gym']
    }
  end
end
