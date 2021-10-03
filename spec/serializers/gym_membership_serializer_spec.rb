require 'rails_helper'

describe 'GymMembershipSerializer', type: :serializer do
  describe 'instance methods' do
    describe '#serializable_hash' do
      context 'when I provide a valid gym membership', :vcr do
        let!(:yelp_gym) { GymFacade.find_gym('gHmS3WIjRRhSWG4OdCQYLA') }
        let(:user) { user_with_gym_membership(yelp_gym_id: yelp_gym.yelp_gym_id) }
        let(:gym_membership) { user.gym_memberships.first }
        let(:gym_membership_hash) { GymMembershipSerializer.new(gym_membership).serializable_hash }
        let(:gym_membership_data) { gym_membership_hash[:data] }
        let(:gym_membership_attributes) { gym_membership_data[:attributes] }
        let(:gym_membership_meta) { gym_membership_data[:meta] }

        it 'formats the single gym membership response for delivery', :aggregate_failures do
          expect(gym_membership_hash).to be_a Hash
          expect(gym_membership_hash.size).to eq 1

          expect(gym_membership_hash).to have_key(:data)

          expect(gym_membership_data).to be_a Hash
          expect(gym_membership_data.size).to eq 4

          expect(gym_membership_data).to have_key(:id)
          expect(gym_membership_data[:id]).to be_a String

          expect(gym_membership_data).to have_key(:type)
          expect(gym_membership_data[:type]).to be_a Symbol
          expect(gym_membership_data[:type]).to eq(:gym_membership)

          expect(gym_membership_data).to have_key(:attributes)
          expect(gym_membership_attributes).to be_a Hash
          expect(gym_membership_attributes.size).to eq 3

          expect(gym_membership_attributes).to have_key(:user_id)
          expect(gym_membership_attributes[:user_id]).to be_an Integer

          expect(gym_membership_attributes).to have_key(:yelp_gym_id)
          expect(gym_membership_attributes[:yelp_gym_id]).to be_a String

          expect(gym_membership_attributes).to have_key(:gym_name)
          expect(gym_membership_attributes[:gym_name]).to be_a String

          expect(gym_membership_meta.size).to eq 2
          expect(gym_membership_meta).to have_key(:address)
          expect(gym_membership_meta).to have_key(:address_details)
          expect(gym_membership_meta[:address]).to be_a String
          expect(gym_membership_meta[:address_details]).to be_a Hash
        end
      end

      context 'when I provide no valid event or events' do
        subject(:empty_gym_membership) { GymMembershipSerializer.new(nil).serializable_hash }

        it 'returns a hash with data as nil' do
          expect(empty_gym_membership).to be_a Hash
          expect(empty_gym_membership.size).to eq(1)

          expect(empty_gym_membership).to have_key(:data)
          expect(empty_gym_membership[:data]).to be_nil
        end
      end
    end
  end
end
