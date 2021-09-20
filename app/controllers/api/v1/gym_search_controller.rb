class Api::V1::GymSearchController < ApplicationController
  def index
    if params[:zip_code].length != 5 || params[:zip_code].blank?
      json_error_response({}, :bad_request)
    else
      found_gyms = GymFacade.query_yelp(params[:zip_code])
      render json: GymSerializer.format_gyms(found_gyms), status: :ok
    end
  end
end
