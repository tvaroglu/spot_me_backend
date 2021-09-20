# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.
class Api::V1::Users::GymMemberships::EventsController < ApplicationController
  # TODO: This method should be refactored to slim it up.
  def create
    user = User.find(params[:user_id])
    gym_membership = GymMembership.find(params[:gym_membership_id])
    user.gym_memberships.find(params[:gym_membership_id])

    event = Event.create!(
      user: user,
      gym_membership: gym_membership,
      date_time: event_params[:date_time],
      activity: event_params[:activity]
    )

    render json: EventSerializer.new(event).serializable_hash, status: :created
  end

  private

  def event_params
    params.permit(:date_time, :activity)
  end
end
