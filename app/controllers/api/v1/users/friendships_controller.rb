# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.
class Api::V1::Users::FriendshipsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    friends = user.followees

    render json: UserSerializer.new(friends).serializable_hash, status: :ok
  end
end
