# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.
class Api::V1::Users::Gyms::EventsController < ApplicationController
  # TODO: This method should be refactored to slim it up.
  def create
    user = User.find(params[:user_id])
    gym = Gym.find(params[:gym_id])
    gym_membership = GymMembership.find_by(user: user, gym: gym)

    if gym_membership.blank?
      render json: error_gym_member_not_found,
             status: :bad_request
      return
    end

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

  def error_gym_member_not_found
    { message: 'your query could not be completed',
      errors: ["User with 'id'=#{params[:user_id]} is not "\
               "a member of Gym with 'id'=#{params[:gym_id]}"] }
  end
end
