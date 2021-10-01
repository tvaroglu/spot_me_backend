# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.
class Api::V1::Users::EventsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    events = if params[:time_frame] == 'past'
               user.past_events(params[:user_id])
             else
               user.upcoming_events(params[:user_id])
             end

    render json: EventSerializer.new(events, { params: { current_user: params[:user_id] } })
            .serializable_hash, status: :ok
  end
end
