require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'Users::Find API', type: :request do
  describe 'GET /api/v1/users/find' do
    let!(:user) { create(:user) }
    let(:user_id) { user.id }
    let(:bad_user_id) { User.last.id + 1 }

    context 'when the user record exists' do
      before { get "/api/v1/users/find", params: { google_id: user.google_id } }

      it 'returns the user', :aggregate_failures do
        expect(json).not_to be_empty

        expect(json_data.size).to eq(3)
        expect(json_data[:id]).to eq(user_id.to_s)
      end

      include_examples 'status code 200'
    end

    context 'when the user record does not exist' do
      before { get "/api/v1/users/find", params: { google_id: bad_user_id } }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find User"])
      end

      include_examples 'status code 404'
    end

    context 'when no params are provided' do
      before { get "/api/v1/users/find" }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["must provide google_id to retrieve user"])
      end

      include_examples 'status code 404'
    end
  end
end
