require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'Gyms API', type: :request do
  describe 'GET /api/v1/gyms/:id' do
    let!(:gyms) { create_list(:gym, 10) }
    let(:gym_id) { gyms.first.id }
    let(:bad_gym_id) { Gym.last.id + 1 }

    context 'when the gym record exists' do
      before { get "/api/v1/gyms/#{gym_id}" }

      it 'returns the gym', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data.size).to eq(3)
        expect(json_data[:id]).to eq(gym_id.to_s)
      end

      include_examples 'status code 200'
    end

    context 'when the gym record does not exist' do
      before { get "/api/v1/gyms/#{bad_gym_id}" }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find Gym with 'id'=#{bad_gym_id}"])
      end

      include_examples 'status code 404'
    end
  end
end
