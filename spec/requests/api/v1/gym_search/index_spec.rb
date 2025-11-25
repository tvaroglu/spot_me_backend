require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'GymSearch API', type: :request do
  describe 'GET /api/v1/gym_search' do
    context 'when a valid location is provided with a plethora of available gyms', :vcr do
      before { get '/api/v1/gym_search?zip_code=34145' }

      it 'returns 50 nearby gyms sorted by distance', :aggregate_failures do
        expect(json).not_to be_empty
        # expect(json_data.size).to eq 50
        expect(json_data.size).to be > 0
        expect(json_data.first[:id]).to be_a(String)
        expect(json_data.first[:attributes].keys).to eq([:name, :address, :address_details, :phone, :gym_member_count])
      end

      include_examples 'status code 200'
    end

    context 'when a valid location is provided with less than 50 available gyms', :vcr do
      before { get '/api/v1/gym_search?zip_code=04572' }

      it 'returns nearby gyms sorted by distance', :aggregate_failures do
        expect(json).not_to be_empty
        # expect(json_data.size).to eq 16
        expect(json_data.size).to be > 0
        expect(json_data.first[:id]).to be_a(String)
        expect(json_data.first[:attributes].keys).to eq([:name, :address, :address_details, :phone, :gym_member_count])
      end

      include_examples 'status code 200'
    end

    context 'when a valid location is provided but 0 gyms are nearby', :vcr do
      before { get '/api/v1/gym_search?zip_code=99723' }

      it 'returns 20 nearby gyms sorted by distance', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data.size).to eq 0
      end

      include_examples 'status code 200'
    end

    context 'when an invalid location is provided', :vcr do
      before { get '/api/v1/gym_search?zip_code=34112352323234545' }

      it 'returns an error', :aggregate_failures do
        expect(json[:code]).to eq 400
        expect(json[:error]).to eq('Invalid zip code')
        expect(json[:status]).to eq 'Bad Request'
      end

      include_examples 'status code 400'
    end
  end
end
