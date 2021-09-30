# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.
class Api::V1::Users::EventsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    # TODO: add flexibility based on query params to retrieve upcoming vs past
    # events (e.g. if we decide to add activity log to dashboard)
    events = user.upcoming_events(params[:user_id])

    options = {}
    options[:include] = [:user]
    render json: EventSerializer.new(events, options).serializable_hash,
           status: :ok
  end
end
