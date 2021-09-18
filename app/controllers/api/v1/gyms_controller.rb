# See spec/concerns/response.rb for #json_response helpers.
class Api::V1::GymsController < ApplicationController
  def show
    gym = Gym.find(params[:id])

    render json: GymSerializer.new(gym).serializable_hash, status: :ok
  end
end
