# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers
class Api::V1::Users::GymsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    gyms = user.gyms

    render json: GymSerializer.new(gyms).serializable_hash, status: :ok
  end
end
