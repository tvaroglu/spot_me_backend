require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'GymSearch API', type: :request do
  describe 'GET /api/v1/gym_search/:id' do
    context 'when a valid yelp gym id is given', :vcr do
      before { get '/api/v1/gym_search/HxK5-XEhjl0x0RR9PAgBVQ' }

      it 'returns a gym', :aggregate_failures do
        expect(json).not_to be_empty

        expect(json_data[:id]).to be_a(String)
        expect(json_data[:id]).to eq('HxK5-XEhjl0x0RR9PAgBVQ')
        expect(json_data[:attributes].keys).to eq([:name, :address, :address_details, :phone])
      end

      include_examples 'status code 200'
    end

    context 'when an invalid yelp gym id is given', :vcr do
      before { get '/api/v1/gym_search/bad_gym_id' }

      it 'returns an error code 400', :aggregate_failures do
        expect(json).not_to be_empty
      end

      include_examples 'status code 400'
    end

    context 'when a valid but unfound yelp gym id is given', :vcr do
      before { get '/api/v1/gym_search/HxK5-XEhjl0x0RR9PAgBVp' }

      it 'returns an error code 404', :aggregate_failures do
        expect(json).not_to be_empty
      end

      include_examples 'status code 404'
    end
  end
end
