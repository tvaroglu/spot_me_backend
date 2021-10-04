# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.

# TODO: add query parameter for relationship
class Api::V1::Users::FriendshipsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    friends = if params[:relationship] == 'followers'
                params[:yelp_gym_id].present? ? user.followers_at_same_gym(params[:yelp_gym_id]) : user.followers
              else
                params[:yelp_gym_id].present? ? user.followees_at_same_gym(params[:yelp_gym_id]) : user.followees
              end

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
