class Api::V1::GymMemberships::UsersController < ApplicationController
  def index
    return error_message if params[:yelp_gym_id].blank?

    users = User.users_at_same_gym(params[:yelp_gym_id])
    options = {}
    options[:meta] = { gym_member_count: users.size }
    render json: UserSerializer.new(users, options).serializable_hash,
           status: :ok
  end

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
