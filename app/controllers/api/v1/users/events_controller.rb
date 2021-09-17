# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.
class Api::V1::Users::EventsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    events = user.events

    render json: EventSerializer.new(events).serializable_hash, status: :ok
  end
end
