require 'rails_helper'

# See spec/support/requests_shared_examples.rb for shared examples
describe 'Users::Gyms::Events API', type: :request do
  describe 'GET /api/v1/users/:user_id/gyms/:gym_id/events/new' do
    # See spec/factories/users.rb for #user_with_gym_friend test setup method
    let!(:user) { user_with_gym_friend }
    let(:gym) { Gym.last }

    context 'when the user is a member of the gym' # do
    #   before { post "/api/v1/users/#{user.id}/gyms/#{gym.id}/events/new", params: valid_attributes }
    #
    #   it 'returns the user, the users friend ids and names, and the gym id and name', :aggregate_failures do
    #     expect(json).not_to be_empty
    #     expect(json_data.size).to eq(3)
    #     expect(json_data[:attributes][:activity]).to eq(activity)
    #     expect(json_data[:attributes][:date_time]).to eq(date_time)
    #     expect(json_data[:attributes][:gym_id]).to eq(gym.id)
    #     expect(json_data[:attributes][:user_id]).to eq(user.id)
    #   end
    #
    #   include_examples 'status code 201'
    # end

    # TODO: Add test for this context
    context 'when the user does not exist'

    # TODO: Add test for this context
    context 'when the gym does not exist'

    # TODO: Add test for this context
    context 'when the user does not belong to the gym'
  end
end
