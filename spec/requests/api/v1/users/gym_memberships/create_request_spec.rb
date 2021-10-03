require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'Users::GymMemberships API', type: :request do
  describe 'POST /api/v1/users/:user_id/gym_memberships', :vcr do
    let!(:yelp_gym) { GymFacade.find_gym('gHmS3WIjRRhSWG4OdCQYLA') }
    let!(:user) { user_with_gym_membership(yelp_gym_id: yelp_gym.yelp_gym_id) }
    let(:gym_membership) { user.gym_memberships.first }
    let(:yelp_gym_id) { gym_membership.yelp_gym_id }
    let(:gym_name) { 'Planet Fitness' }
    let(:valid_attributes) do
      {
        user_id: user.id,
        yelp_gym_id: yelp_gym_id,
        gym_name: gym_name
      }
    end

    context 'when the request is valid' do
      before { post "/api/v1/users/#{user.id}/gym_memberships", params: valid_attributes }

      it 'creates a gym member', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data.size).to eq 4
        expect(json_data[:attributes][:user_id]).to eq user.id
        expect(json_data[:attributes][:yelp_gym_id]).to eq yelp_gym_id
        expect(json_data[:attributes][:gym_name]).to eq gym_name
        expect(json_data[:meta][:address]).to eq yelp_gym.address
        expect(json_data[:meta][:address_details]).to eq yelp_gym.address_details
      end

      include_examples 'status code 201'
    end

    context 'when the user does not exist' do
      let(:bad_user_id) { User.last.id + 1 }

      before { post "/api/v1/users/#{bad_user_id}/gym_memberships", params: valid_attributes }

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

    context 'when the the gym name is not provided' do
      let(:invalid_attributes) do
        {
          user_id: user.id,
          yelp_gym_id: yelp_gym_id
        }
      end

      before { post "/api/v1/users/#{user.id}/gym_memberships", params: invalid_attributes }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        message = 'your record could not be saved'
        error_message = ["Gym name can't be blank"]

        expect(json[:message]).to eq(message)
        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(error_message)
      end

      include_examples 'status code 422'
    end

    context 'when the the yelp_gym_id is not provided' do
      let(:invalid_attributes) do
        {
          user_id: user.id,
          gym_name: gym_name
        }
      end

      before { post "/api/v1/users/#{user.id}/gym_memberships", params: invalid_attributes }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        message = 'your record could not be saved'
        error_message = ["Yelp gym can't be blank"]

        expect(json[:message]).to eq(message)
        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(error_message)
      end

      include_examples 'status code 422'
    end
    #
    # TODO: Add validation that the yelp_gym_id must be valid in order to create
    #       the record.
    # context 'when the gym does not exist' do
    #   let(:bad_gym_id) { Gym.last.id + 1 }
    #
    #   before { post "/api/v1/users/#{user.id}/gym_memberships", params: valid_attributes }
    #
    #   it 'returns an error message', :aggregate_failures do
    #     expect(json).not_to be_empty
    #     expect(json.size).to eq(2)
    #
    #     message = 'your query could not be completed'
    #     error_message = ["Couldn't find Gym with 'id'=#{bad_gym_id}"]
    #
    #     expect(json[:message]).to eq(message)
    #     expect(json[:errors]).to be_an Array
    #     expect(json[:errors]).to eq(error_message)
    #   end
    #
    #   include_examples 'status code 404'
    # end
  end
end
