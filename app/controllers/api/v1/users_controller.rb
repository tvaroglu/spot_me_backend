# See spec/concerns/response.rb for #json_response and #json_error_response
# helpers.
class Api::V1::UsersController < ApplicationController
  def show
    user = User.find(params[:id])

    render json: UserSerializer.new(user).serializable_hash, status: :ok
  end

  def update
    user = User.find(params[:id])
    user.update!(user_params)

    render json: UserSerializer.new(user).serializable_hash, status: :ok
  end

  def create
    user = User.create!(user_create_params)

    render json: UserSerializer.new(user).serializable_hash, status: :created
  end

  private

  def user_params
    params.permit(:full_name, :zip_code, :summary, :goal, :availability_morning,
                  :availability_afternoon, :availability_evening)
  end

  def user_create_params
    params.permit(:zip_code, :summary, :goal, :availability_morning,
                  :availability_afternoon, :availability_evening, :full_name,
                  :email, :google_id, :google_image_url)
  end
end
