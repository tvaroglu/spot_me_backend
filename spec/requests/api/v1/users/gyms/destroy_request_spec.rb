require 'rails_helper'

# See spec/support/requests_shared_examples.rb for shared examples
describe 'Users::Gyms API', type: :request do
  describe 'DELETE /api/v1/users/:user_id/gyms/:id' do
    # See spec/factories/users.rb for #user_with_gym test setup method
    let!(:user) { user_with_gym }
    let(:gym) { Gym.last }

    context 'when the user exists' do
      before { delete "/api/v1/users/#{user.id}/gyms/#{gym.id}" }

      include_examples 'status code 204'
    end

    context 'when the user does not exist' do
      let(:bad_user_id) { User.last.id + 1 }

      before { delete "/api/v1/users/#{bad_user_id}/gyms/#{gym.id}" }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find User with 'id'=#{bad_user_id}"])
      end

      include_examples 'status code 404'
    end

    context 'when the gym does not exist' do
      let(:bad_gym_id) { Gym.last.id + 1 }

      before { delete "/api/v1/users/#{user.id}/gyms/#{bad_gym_id}" }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)
        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find Gym with 'id'=#{bad_gym_id}"])
      end

      include_examples 'status code 404'
    end

    context 'when the user is not a member of the gym' do
      let(:new_gym) { create(:gym) }

      before { delete "/api/v1/users/#{user.id}/gyms/#{new_gym.id}" }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["User with 'id'=#{user.id} is not a member of Gym with 'id'=#{new_gym.id}"])
      end

      include_examples 'status code 400'
    end
  end
end
