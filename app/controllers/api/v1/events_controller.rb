class Api::V1::EventsController < ApplicationController
  def index
    events = Event.future_events
    render json: EventSerializer.new(events)
  end
end
