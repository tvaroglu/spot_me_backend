require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json helper.
describe 'Users::Friendships API', type: :request do
  describe 'DELETE /api/v1/users/:user_id/friendships/:id' do
    # See spec/factories/users.rb for #user_with_friend test setup method
    let!(:user) { user_with_friend }
    let(:friend) { user.followees.first }

    context 'when the user and friend exist' do
      before { delete "/api/v1/users/#{user.id}/friendships/#{friend.id}" }

      include_examples 'status code 204'
    end

    context 'when the user does not exist' do
      let(:bad_user_id) { User.last.id + 1 }

      before { delete "/api/v1/users/#{bad_user_id}/friendships/#{friend.id}" }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find User with 'id'=#{bad_user_id}"])
      end

      include_examples 'status code 404'
    end

    context 'when the friend does not exist' do
      let(:bad_user_id) { User.last.id + 1 }

      before { delete "/api/v1/users/#{user.id}/friendships/#{bad_user_id}" }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find User with 'id'=#{bad_user_id}"])
      end

      include_examples 'status code 404'
    end
  end
end
