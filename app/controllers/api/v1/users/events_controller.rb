# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.
class Api::V1::Users::EventsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    # TODO: add flexibility based on query params to retrieve upcoming vs past events
    # (i.e. if we decide to add activity log to dashboard)
    events = user.upcoming_events

    render json: EventSerializer.new(events).serializable_hash, status: :ok
  end
end
