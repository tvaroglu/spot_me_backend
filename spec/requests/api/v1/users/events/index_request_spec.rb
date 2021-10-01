require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'Users::Events API', type: :request do
  describe 'GET /api/v1/users/:id/events' do
    # See spec/factories/users.rb for #experienced_user test setup method
    experienced_user
    let(:user_id) { user1.id }
    let(:invited_user_id) { user2.id }
    let(:no_event_user_id) { user9.id }
    let(:bad_user_id) { User.last.id + 1 }

    let!(:gym_id) { user1.gym_memberships.first.id }
    let!(:past_event) { create(:event, date_time: DateTime.yesterday, user_id: user2.id, gym_membership_id: gym_id) }

    context 'when the user has upcoming events they are hosting' do
      before { get "/api/v1/users/#{user_id}/events" }

      it "returns the user's events and the invited friend", :aggregate_failures do
        expect(json).not_to be_empty

        expect(json_data.size).to eq(7)
        expect(json_data.first[:id]).to eq(event1_1a_2.id.to_s)

        meta = json_data.first[:meta]

        expect(meta.size).to eq 2
        expect(meta[:friend_name]).to eq user2.full_name
        expect(meta[:friend_role]).to eq 'invited'
      end

      include_examples 'status code 200'
    end

    context 'when the user has upcoming events they are invited to' do
      before { get "/api/v1/users/#{invited_user_id}/events" }

      it "returns the user's events and the host of the event", :aggregate_failures do
        expect(json).not_to be_empty

        expect(json_data.size).to eq(2)
        expect(json_data.first[:id]).to eq(event1_1a_2.id.to_s)
        expect(json_data.last[:id]).to eq(event1_2a_2.id.to_s)

        meta = json_data.first[:meta]

        expect(meta.size).to eq 2
        expect(meta[:friend_name]).to eq user1.full_name
        expect(meta[:friend_role]).to eq 'host'
      end

      include_examples 'status code 200'
    end

    context 'when the user has events they had hosted in the past' do
      before { get "/api/v1/users/#{user_id}/events?time_frame=past" }

      it "returns the user's events and the invited friend", :aggregate_failures do
        expect(json).not_to be_empty

        expect(json_data.size).to eq(1)
        expect(json_data.first[:id]).to eq(past_event.id.to_s)

        meta = json_data.first[:meta]

        expect(meta.size).to eq 2
        expect(meta[:friend_name]).to eq user2.full_name
        expect(meta[:friend_role]).to eq 'invited'
      end

      include_examples 'status code 200'
    end

    context 'when the user has events they were invited to in the past' do
      before { get "/api/v1/users/#{invited_user_id}/events?time_frame=past" }

      it "returns the user's events and the host of the event", :aggregate_failures do
        expect(json).not_to be_empty

        expect(json_data.size).to eq(1)
        expect(json_data.first[:id]).to eq(past_event.id.to_s)

        meta = json_data.first[:meta]

        expect(meta.size).to eq 2
        expect(meta[:friend_name]).to eq user1.full_name
        expect(meta[:friend_role]).to eq 'host'
      end

      include_examples 'status code 200'
    end

    context 'when the user record does not exist' do
      before { get "/api/v1/users/#{bad_user_id}/events" }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find User with 'id'=#{bad_user_id}"])
      end

      include_examples 'status code 404'
    end

    context 'when the user has no events' do
      before { get "/api/v1/users/#{no_event_user_id}/events" }

      include_examples 'returns nil data'
      include_examples 'status code 200'
    end
  end
end
