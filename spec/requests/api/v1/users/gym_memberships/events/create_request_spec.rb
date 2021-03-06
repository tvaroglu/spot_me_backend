require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'Users::GymMemberships::Events API', type: :request do
  describe 'POST /api/v1/users/:user_id/gym_memberships/:gym_membership_id/events' do
    # See spec/factories/users.rb for #user_with_gym_friend test setup method
    let!(:user) { user_with_gym_friend }
    let!(:gym_membership) { user.gym_memberships.first }
    let(:friend) { User.last }
    let(:activity) { 'Lifting' }
    let(:date_time) { '2022-09-24T00:24:11.000Z' }
    let(:valid_attributes) do
      {
        activity: activity,
        date_time: date_time,
        gym_membership_id: gym_membership.id,
        user_id: friend.id
      }
    end

    context 'when the request is valid' do
      before { post "/api/v1/users/#{friend.id}/gym_memberships/#{gym_membership.id}/events", params: valid_attributes }

      it 'creates an event', :aggregate_failures do
        expect(json).not_to be_empty

        expect(json_data.size).to eq(4)
        expect(json_data[:attributes][:activity]).to eq(activity)
        expect(json_data[:attributes][:date_time]).to eq(date_time)
        expect(json_data[:attributes][:gym_membership_id]).to eq(gym_membership.id)
        expect(json_data[:attributes][:user_id]).to eq(friend.id)

        expect(json_data[:meta][:friend_name]).to eq(friend.full_name)
        expect(json_data[:meta][:friend_role]).to eq('invited')
      end

      include_examples 'status code 201'
    end

    context 'when the request is invalid' do
      before { post "/api/v1/users/#{user.id}/gym_memberships/#{gym_membership.id}/events", params: { activity: 100 } }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        message = 'your record could not be saved'
        error_message = ["Date time can't be blank"]

        expect(json[:message]).to eq(message)
        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(error_message)
      end

      include_examples 'status code 422'
    end

    context 'when the user does not exist' do
      let(:bad_user_id) { User.last.id + 1 }

      before { post "/api/v1/users/#{bad_user_id}/gym_memberships/#{gym_membership.id}/events", params: valid_attributes }

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

    context 'when the gym membership does not exist' do
      let(:bad_gym_membership_id) { GymMembership.last.id + 1 }

      before { post "/api/v1/users/#{user.id}/gym_memberships/#{bad_gym_membership_id}/events", params: valid_attributes }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        message = 'your query could not be completed'
        error_message = ["Couldn't find GymMembership with 'id'=#{bad_gym_membership_id}"]

        expect(json[:message]).to eq(message)
        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(error_message)
      end

      include_examples 'status code 404'
    end

    context 'when the user does not belong to the gym' do
      let(:new_gym_membership) { create(:gym_membership) }

      before { post "/api/v1/users/#{user.id}/gym_memberships/#{new_gym_membership.id}/events", params: valid_attributes }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        message = 'your query could not be completed'
        error_message = ['user does not belong to this gym']

        expect(json[:message]).to eq(message)
        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(error_message)
      end

      include_examples 'status code 400'
    end
  end
end
