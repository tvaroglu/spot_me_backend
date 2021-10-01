# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.
class Api::V1::Users::GymMemberships::EventsController < ApplicationController
  def create
    friend = User.find(params[:user_id])
    current_user_gym_membership = GymMembership.find(params[:gym_membership_id])
    friend_gym_membership = friend.gym_memberships.find_by(yelp_gym_id: current_user_gym_membership.yelp_gym_id)
    return error_message if friend_gym_membership.nil?

    event = Event.create!(
      user: friend,
      gym_membership: current_user_gym_membership,
      date_time: event_params[:date_time],
      activity: event_params[:activity]
    )
    render json: EventSerializer.new(
      event, { params: { current_user: current_user_gym_membership.user_id.to_s } }
    ).serializable_hash, status: :created
  end

  def destroy
    User.find(params[:user_id])
    GymMembership.find(params[:gym_membership_id])
    event = Event.find(params[:id])

    event.destroy!
  end

  private

  def event_params
    params.permit(:date_time, :activity)
  end

  def error_message
    render(
      json: {
        message: 'your query could not be completed',
        errors: ['user does not belong to this gym']
      },
      status: :bad_request
    )
  end
end
