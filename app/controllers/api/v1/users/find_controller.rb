# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.
class Api::V1::Users::FindController < ApplicationController
  def index
    return render json: error_message, status: :not_found if params[:google_id].blank?

    user = User.find_by!(google_id: params[:google_id])

    render json: UserSerializer.new(user).serializable_hash, status: :ok
  end

  private

  def error_message
    {
      message: "your query could not be completed",
      errors: ["must provide google_id to retrieve user"]
    }
  end
end
