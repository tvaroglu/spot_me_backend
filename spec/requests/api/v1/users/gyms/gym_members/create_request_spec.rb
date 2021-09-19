require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'Users::Gyms::GymMembers API', type: :request do
  describe 'POST /api/v1/users/:user_id/gyms/:gym_id/gym_members' do
    let!(:user) { create(:user) }
    let!(:gym) { create(:gym) }
    let(:valid_attributes) do
      {
        user_id: user.id,
        gym_id: gym.id
      }
    end

    context 'when the request is valid' do
      before { post "/api/v1/users/#{user.id}/gyms/#{gym.id}/gym_members", params: valid_attributes }

      it 'creates a gym member', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data.size).to eq(3)
        expect(json_data[:attributes][:gym_id]).to eq(gym.id)
        expect(json_data[:attributes][:user_id]).to eq(user.id)
      end

      include_examples 'status code 201'
    end

    context 'when the user does not exist' do
      let(:bad_user_id) { User.last.id + 1 }

      before { post "/api/v1/users/#{bad_user_id}/gyms/#{gym.id}/gym_members", params: valid_attributes }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        message = 'your query could not be completed'
        error_message = ["Couldn't find User with 'id'=#{bad_user_id}"]

        expect(json[:message]).to eq(message)
        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(error_message)
      end

      include_examples 'status code 404'
    end

    context 'when the gym does not exist' do
      let(:bad_gym_id) { Gym.last.id + 1 }

      before { post "/api/v1/users/#{user.id}/gyms/#{bad_gym_id}/gym_members", params: valid_attributes }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        message = 'your query could not be completed'
        error_message = ["Couldn't find Gym with 'id'=#{bad_gym_id}"]

        expect(json[:message]).to eq(message)
        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(error_message)
      end

      include_examples 'status code 404'
    end
  end
end
