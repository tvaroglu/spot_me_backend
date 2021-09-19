class Api::V1::GymSearchController < ApplicationController
  before_action :find_gyms, only: [:index]

  def index
    render json: Gym.new(find_gyms).serializable_hash,
           status: :ok
  end

  private

  def find_gyms
    json_error_response({}, :bad_request) if params[:zip_code].length != 5
    GymSearchFacade.query_yelp(params[:zip_code]) if params[:zip_code]
  end
end
