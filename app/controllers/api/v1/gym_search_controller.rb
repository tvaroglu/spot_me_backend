class Api::V1::GymSearchController < ApplicationController
  def index
    if params[:zip_code].length != 5 || params[:zip_code].blank?
      json_error_response('Invalid zip code', :bad_request)
    else
      found_gyms = GymFacade.query_yelp(params[:zip_code])
      render json: GymSerializer.format_gyms(found_gyms), status: :ok
    end
  end

  def show
    found_gym = GymFacade.find_gym(params[:id])
    if found_gym.is_a?(Hash) && found_gym[:errors].present?
      render json: found_gym[:errors], status: found_gym[:code]
    else
      render json: GymSerializer.format_gym(found_gym), status: :ok
    end
  end
end
