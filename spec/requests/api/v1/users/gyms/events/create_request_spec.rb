require 'rails_helper'

# See spec/support/requests_shared_examples.rb for shared examples
describe 'Users::Gyms::Events API', type: :request do
  describe 'POST /api/v1/users/:user_id/gyms/:gym_id/events' do
    # See spec/factories/users.rb for #user_with_gym_friend test setup method
    let!(:user) { user_with_gym_friend }
    let(:gym) { Gym.first }
    let(:activity) { 'Lifting' }
    let(:date_time) { '2022-09-24T00:24:11.000Z' }
    let(:valid_attributes) do
      {
        activity: activity,
        date_time: date_time,
        gym_id: gym.id,
        user_id: user.id
      }
    end

    context 'when the request is valid' do
      before { post "/api/v1/users/#{user.id}/gyms/#{gym.id}/events", params: valid_attributes }

      it 'creates an event', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data.size).to eq(3)
        expect(json_data[:attributes][:activity]).to eq(activity)
        expect(json_data[:attributes][:date_time]).to eq(date_time)
        expect(json_data[:attributes][:gym_id]).to eq(gym.id)
        expect(json_data[:attributes][:user_id]).to eq(user.id)
      end

      include_examples 'status code 201'
    end

    context 'when the request is invalid' do
      before { post "/api/v1/users/#{user.id}/gyms/#{gym.id}/events", params: { activity: 100 } }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        message = 'your record could not be saved'
        error_message = ["Date time can't be blank"]

        expect(json[:message]).to eq(message)
        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(error_message)
      end

      include_examples 'status code 422'
    end
  end
end
