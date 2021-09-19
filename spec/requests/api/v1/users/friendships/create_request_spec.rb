require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json and #json_data helpers.
describe 'Users::Friendships API', type: :request do
  describe 'POST /api/v1/users/:user_id/friendships' do
    let!(:user) { create(:user) }
    let!(:friend) { create(:user) }
    let(:valid_attributes) { { followee_id: friend.id } }

    context 'when the request is valid' do
      before { post "/api/v1/users/#{user.id}/friendships", params: valid_attributes }

      it 'creates a friendship', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json_data.size).to eq(3)
        expect(json_data[:attributes][:follower_id]).to eq(user.id)
        expect(json_data[:attributes][:followee_id]).to eq(friend.id)
      end

      include_examples 'status code 201'
    end

    context 'when the user does not exist' do
      let(:bad_user_id) { User.last.id + 1 }

      before { post "/api/v1/users/#{bad_user_id}/friendships", params: valid_attributes }

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

    context 'when the friend user does not exist' do
      let(:bad_user_id) { User.last.id + 1 }
      let(:invalid_attributes) { { followee_id: bad_user_id } }

      before { post "/api/v1/users/#{user.id}/friendships", params: invalid_attributes }

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
  end
end
