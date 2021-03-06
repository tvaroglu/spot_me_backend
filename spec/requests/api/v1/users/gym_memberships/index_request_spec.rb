require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'Users::GymMemberhips API', type: :request do
  describe 'GET /api/v1/users/:id/gym_memberships', :vcr do
    # See spec/factories/users.rb for #experienced_user test setup method
    experienced_user
    let(:user_id) { user1.id }
    let(:gym_membership1_id) { gym_mem1_1.id }
    let(:gym_membership2_id) { gym_mem1_2.id }
    let(:no_gym_user_id) { user9.id }
    let(:bad_user_id) { User.last.id + 1 }

    context 'when the user gym membership records exists' do
      before { get "/api/v1/users/#{user_id}/gym_memberships" }

      it 'returns the users gym memberships', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data.size).to eq(2)
        expect(json_data.first[:id]).to eq(gym_membership1_id.to_s)
        expect(json_data.second[:id]).to eq(gym_membership2_id.to_s)
        expect(json_data.first[:meta][:address]).to eq GymFacade.find_gym(gym1).address
        expect(json_data.first[:meta][:address_details]).to eq GymFacade.find_gym(gym1).address_details
        expect(json_data.second[:meta][:address]).to eq GymFacade.find_gym(gym2).address
        expect(json_data.second[:meta][:address_details]).to eq GymFacade.find_gym(gym2).address_details
      end

      include_examples 'status code 200'
    end

    context 'when the user record does not exist' do
      before { get "/api/v1/users/#{bad_user_id}/gym_memberships" }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find User with 'id'=#{bad_user_id}"])
      end

      include_examples 'status code 404'
    end

    context 'when the user has no gym memberships' do
      before { get "/api/v1/users/#{no_gym_user_id}/gym_memberships" }

      include_examples 'returns nil data'
      include_examples 'status code 200'
    end
  end
end
