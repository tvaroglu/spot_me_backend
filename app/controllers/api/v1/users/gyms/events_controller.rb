# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.
class Api::V1::Users::Gyms::EventsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    gym = Gym.find(params[:gym_id])
    event = Event.create!(
      user: user,
      gym: gym,
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
