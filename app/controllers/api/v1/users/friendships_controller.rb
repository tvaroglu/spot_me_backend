# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.
class Api::V1::Users::FriendshipsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    friends = user.followees

    render json: UserSerializer.new(friends).serializable_hash, status: :ok
  end

  def create
    follower = User.find(params[:user_id])
    followee = User.find(params[:followee_id])
    friendship = Friendship.create!(follower_id: follower.id,
                                    followee_id: followee.id)

    render json: FriendshipSerializer.new(friendship).serializable_hash,
           status: :created
  end

  def destroy
    follower = User.find(params[:user_id])
    followee = User.find(params[:id])
    friendship = Friendship.find_by(follower_id: follower.id,
                                    followee_id: followee.id)
    friendship.destroy!
  end
end
