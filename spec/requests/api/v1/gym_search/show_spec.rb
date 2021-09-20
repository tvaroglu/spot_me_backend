require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'GymSearch API', type: :request do
  describe 'GET /api/v1/gym_search/:id' do
    context 'when a valid yelp gym id is given' do
      it 'returns a gym', :aggregate_failures, :vcr do
        get '/api/v1/gym_search/HxK5-XEhjl0x0RR9PAgBVQ'
        JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        expect(json).not_to be_empty
        expect(json_data[:id]).to be_a(String)
        expect(json_data[:id]).to eq('HxK5-XEhjl0x0RR9PAgBVQ')
        expect(json_data[:attributes].keys).to eq([:name, :address, :phone])
      end
    end

    context 'when a invalid yelp gym id is given' do
      it 'returns an error code 400', :aggregate_failures, :vcr do
        get '/api/v1/gym_search/bad_gym_id'
        JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 400
        expect(json).not_to be_empty
      end
    end

    context 'when a valid but unfound yelp gym id is given' do
      it 'returns an error code 404', :aggregate_failures, :vcr do
        get '/api/v1/gym_search/HxK5-XEhjl0x0RR9PAgBVp'
        JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 404
        expect(json).not_to be_empty
      end
    end
  end
end
