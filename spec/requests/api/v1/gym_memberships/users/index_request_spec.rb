require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'GymMemberships::Users API', type: :request do
  describe 'GET /api/v1/gym_memberships/users' do
    context 'when there are users that belong to a given gym' do
      # See spec/factories/users.rb for #experienced_user test setup method
      experienced_user

      context 'when I do not provide query params' do
        before { get '/api/v1/gym_memberships/users' }

        it 'returns an error message', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json.size).to eq(2)

          expect(json[:message]).to eq('your query could not be completed')

          expect(json[:errors]).to be_an Array
          expect(json[:errors]).to eq(['must provide yelp_gym_id to retrieve members at this gym'])
        end

        include_examples 'status code 404'
      end

      context 'when I provide yelp_gym_id in query params' do
        let(:gym1_members) { [user1, user2, user3, user5] }

        before { get '/api/v1/gym_memberships/users', params: { yelp_gym_id: gym1 } }

        it 'returns the users that are members of the given gym', :aggregate_failures do
          expect(json).not_to be_empty
          expect(json[:meta][:gym_member_count]).to eq(4)
          expect(json_data.size).to eq(4)

          expect(json_data.first[:id]).to eq(user1.id.to_s)
          expect(json_data.second[:id]).to eq(user2.id.to_s)
          expect(json_data.third[:id]).to eq(user3.id.to_s)
          expect(json_data.fourth[:id]).to eq(user5.id.to_s)
        end

        include_examples 'status code 200'
      end
    end

    context 'when there are no users that belong to a given gym' do
      before { get '/api/v1/gym_memberships/users', params: { yelp_gym_id: 'c2jzsndq84rvn9fbckeec2' } }

      include_examples 'returns nil data'
      include_examples 'status code 200'
    end
  end
end
