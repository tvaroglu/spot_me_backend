require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'Users::GymMembers API', type: :request do
  describe 'GET /api/v1/users/:id/gym_members' do
    let!(:user1) { user_with_gym_membership }
    let!(:yelp_gym_id) { user1.gym_memberships.first.yelp_gym_id }
    let!(:user2) { create(:user) }
    let!(:gym_membership) { create(:gym_membership, user: user2, yelp_gym_id: yelp_gym_id) }

    context 'when the user record exists' do
      before { get "/api/v1/users/#{user1.id}/gym_members?yelp_gym_id=#{yelp_gym_id}", params: { yelp_gym_id: yelp_gym_id } }

      it 'returns the users at the same gym that the current user is NOT already friends with', :aggregate_failures do
        expect(json).not_to be_empty

        expect(json_data.size).to eq(1)
        expect(json_data.first[:id]).to eq(user2.id.to_s)
      end

      include_examples 'status code 200'
    end

    context 'when the user record does not exist' do
      let(:bad_user_id) { User.last.id + 1 }

      before { get "/api/v1/users/#{bad_user_id}/gym_members?", params: { yelp_gym_id: yelp_gym_id } }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find User with 'id'=#{bad_user_id}"])
      end

      include_examples 'status code 404'
    end

    context 'when no params are provided' do
      before { get "/api/v1/users/#{user1.id}/gym_members", params: {} }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(['must provide yelp_gym_id to retrieve members at this gym'])
      end

      include_examples 'status code 404'
    end
  end
end
