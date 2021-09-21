require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'Users::GymMemberships::Events API', type: :request do
  describe 'DELETE /api/v1/users/:user_id/gym_memberships/:gym_membership_id/events/:id' do
    # See spec/factories/users.rb for #user_with_gym_friend test setup method
    let!(:user) { user_with_gym_friend }
    let!(:gym_membership) { user.gym_memberships.last }
    let(:friend) { User.last }
    let!(:event) { create(:event, gym_membership: gym_membership, user: friend) }

    context 'when the event exists' do
      before { delete "/api/v1/users/#{user.id}/gym_memberships/#{gym_membership.id}/events/#{event.id}" }

      it 'deletes the event', :aggregate_failures do
        expect { Event.find(event.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      include_examples 'status code 204'
    end

    context 'when the user does not exist' do
      let(:bad_user_id) { User.last.id + 1 }

      before { delete "/api/v1/users/#{bad_user_id}/gym_memberships/#{gym_membership.id}/events/#{event.id}" }

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

      before { delete "/api/v1/users/#{user.id}/gym_memberships/#{bad_gym_membership_id}/events/#{event.id}" }

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

    context 'when the event does not exist' do
      let(:bad_event_id) { Event.last.id + 1 }

      before { delete "/api/v1/users/#{user.id}/gym_memberships/#{gym_membership.id}/events/#{bad_event_id}" }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        message = 'your query could not be completed'
        error_message = ["Couldn't find Event with 'id'=#{bad_event_id}"]

        expect(json[:message]).to eq(message)
        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(error_message)
      end

      include_examples 'status code 404'
    end
  end
end
