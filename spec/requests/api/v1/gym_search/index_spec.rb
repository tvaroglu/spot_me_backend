require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'GymSearch API', type: :request do
  describe 'GET /api/v1/gym_search' do
    context 'when a valid location is provided with a plethora of gyms' do
      it 'returns 20 nearby gyms sorted by distance', :aggregate_failures, :vcr do
        get '/api/v1/gym_search?zip_code=34145'
        JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 200
        expect(json).not_to be_empty
        expect(json_data.size).to eq 20
        expect(json_data.first[:id]).to be_a(String)
      end
    end

    context 'when a valid location is provided with less than 20 available gyms' do
      it 'returns 20 nearby gyms sorted by distance', :aggregate_failures, :vcr do
        get '/api/v1/gym_search?zip_code=04572'
        JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 200
        expect(json).not_to be_empty
        expect(json_data.size).to eq 16
        expect(json_data.first[:id]).to be_a(String)
      end
    end

    context 'when a valid location is provided but 0 gyms are nearby' do
      it 'returns 20 nearby gyms sorted by distance', :aggregate_failures, :vcr do
        get '/api/v1/gym_search?zip_code=89405'
        JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 200
        expect(json).not_to be_empty
        expect(json_data.size).to eq 0
      end
    end

    context 'when an invalid location is provided' do
      it 'returns an error', :aggregate_failures, :vcr do
        get '/api/v1/gym_search?zip_code=34112352323234545'
        JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 400
        expect(json[:code]).to eq 400
        expect(json[:error]).to eq("Invalid zip code")
        expect(json[:status]).to eq 'Bad Request'
      end
    end
  end
end
