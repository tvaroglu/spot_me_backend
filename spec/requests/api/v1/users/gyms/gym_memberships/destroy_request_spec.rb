require 'rails_helper'

# See spec/support/shared_examples/ for shared examples for tests where
# `include_examples` is used. See Shared Examples in the RSpec docs for more
# info:
#   https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
# See spec/support/request_spec_helper.rb for #json helper.
describe 'Users::GymMemberships API', type: :request do
  describe 'DELETE /api/v1/users/:user_id/gym_memberships/:id' do
    # See spec/factories/users.rb for #gym_membership test setup method
    let!(:user) { user_with_gym_membership }
    let(:gym_membership) { user.gym_memberships.last }

    context 'when the user exists' do
      before { delete "/api/v1/users/#{user.id}/gym_memberships/#{gym_membership.id}" }

      include_examples 'status code 204'
    end

    context 'when the user does not exist' do
      let(:bad_user_id) { User.last.id + 1 }

      before { delete "/api/v1/users/#{bad_user_id}/gym_memberships/#{gym_membership.id}" }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)

        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find User with 'id'=#{bad_user_id}"])
      end

      include_examples 'status code 404'
    end

    context 'when the gym membership does not exist' do
      let(:bad_gym_membership_id) { GymMembership.last.id + 1 }

      before { delete "/api/v1/users/#{user.id}/gym_memberships/#{bad_gym_membership_id}" }

      it 'returns an error message', :aggregate_failures do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)
        expect(json[:message]).to eq('your query could not be completed')

        expect(json[:errors]).to be_an Array
        expect(json[:errors]).to eq(["Couldn't find GymMembership with 'id'=#{bad_gym_membership_id}"])
      end

      include_examples 'status code 404'
    end
  end
end
