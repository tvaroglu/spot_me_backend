require 'rails_helper'

# See spec/support/requests_shared_examples.rb for shared examples
describe 'Users::Friendships API', type: :request do
  # describe 'POST /api/v1/users/:user_id/friendships' do
  #   let!(:user) { create(:user) }
  #   let!(:friend) { create(:user) }
  #   let(:valid_attributes) do
  #     # TODO: follower_id should come from the path.  The followee_id should be
  #     #       provided as a query param.
  #     {
  #       followee_id: friend.id
  #     }
  #   end
  #
  #   context 'when the request is valid' do
  #     before { post "/api/v1/users/#{user.id}/friendships", params: valid_attributes }
  #
  #     xit 'creates a gym member', :aggregate_failures do
  #       expect(json).not_to be_empty
  #       expect(json_data.size).to eq(3)
  #       expect(json_data[:attributes][:gym_id]).to eq(gym.id)
  #       expect(json_data[:attributes][:user_id]).to eq(user.id)
  #     end
  #
  #     include_examples 'status code 201'
  #   end
  #
  #   context 'when the user does not exist' do
  #     let(:bad_user_id) { User.last.id + 1}
  #
  #     before { post "/api/v1/users/#{bad_user_id}/friendships", params: valid_attributes }
  #
  #     xit 'returns an error message', :aggregate_failures do
  #       expect(json).not_to be_empty
  #       expect(json.size).to eq(2)
  #
  #       message = 'your query could not be completed'
  #       error_message = ["Couldn't find User with 'id'=#{bad_user_id}"]
  #
  #       expect(json[:message]).to eq(message)
  #       expect(json[:errors]).to be_an Array
  #       expect(json[:errors]).to eq(error_message)
  #     end
  #
  #     include_examples 'status code 404'
  #   end
  # end
end
