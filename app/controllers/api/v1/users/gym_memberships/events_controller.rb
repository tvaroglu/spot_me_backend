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

  def destroy
    user = User.find(params[:user_id])
    event = user.events.find_by(id: params[:id], gym_membership_id: params[:gym_membership_id])

    return event.destroy! if event

    if GymMembership.find(params[:gym_membership_id]).blank?
      render json: error_message(params[:gym_membership_id]), status: :not_found
    else
      render json: error_message(params[:id]), status: :not_found
    end
  end

  private

  def event_params
    params.permit(:date_time, :activity)
  end

  def error_message(param)
    {
      message: 'your query could not be completed',
      errors: ["Couldn't find Event with 'id'=#{param}"]
    }
  end
end
