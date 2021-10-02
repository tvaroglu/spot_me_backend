# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.

# TODO: add query parameter for relationship
class Api::V1::Users::FriendshipsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    friends = #if params[:relationship] == 'followers'
                if params[:yelp_gym_id]
              # if params[:relationship] == 'followee'
                # user.followees (current user.friends_at_same_gym method call )
              # elsif params[:relationship] == 'follower'
                # user.followers (new method call, pending)
              # end
                user.followees_at_same_gym(params[:yelp_gym_id])
              else
                # follow same conditional flow as above, independent of GymMembership
                user.followees
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
