# See spec/concerns/response.rb for #json_response and #json_error_response helpers
class Api::V1::UsersController < ApplicationController
  def show
    user = User.find(params[:id])

    render json: UserSerializer.new(user).serializable_hash, status: :ok
  end
end
