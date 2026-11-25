require 'rails_helper'

RSpec.describe GymMembership, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:events).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:user_id) }
    it { should validate_presence_of(:yelp_gym_id) }
    it { should validate_presence_of(:gym_name) }
  end

  describe 'factories' do
    describe 'gym membership' do
      it 'is valid with valid attributes' do
        gym_membership = create(:gym_membership)
        expect(gym_membership).to be_valid
      end
    end
  end

  describe 'Yelp lookup resilience' do
    let(:gym_membership) { create(:gym_membership) }

    it 'performs only one Yelp lookup when both address fields are read' do
      # Construct a real Gym PORO for the type check:
      gym = Gym.new(id: gym_membership.yelp_gym_id, name: 'Test Gym',
                    location: { display_address: ['123 Main St'], city: 'Denver' },
                    display_phone: '')
      allow(GymFacade).to receive(:find_gym).with(gym_membership.yelp_gym_id).and_return(gym)

      expect(gym_membership.address).to eq('123 Main St')
      expect(gym_membership.address_details[:city]).to eq('Denver')
      expect(GymFacade).to have_received(:find_gym).once
    end

    it 'returns empty address metadata instead of crashing on a Yelp error' do
      allow(GymFacade).to receive(:find_gym).and_return(errors: { error: 'rate limited' })
      allow(Rails.logger).to receive(:warn)

      expect(gym_membership.address).to be_nil
      expect(gym_membership.address_details).to eq({})
      expect(GymFacade).to have_received(:find_gym).once
    end

    it 'returns empty address metadata when the HTTP connection fails' do
      allow(GymFacade).to receive(:find_gym).and_raise(Faraday::ConnectionFailed, 'unavailable')
      allow(Rails.logger).to receive(:warn)

      expect(gym_membership.address_details).to eq({})
      expect(gym_membership.address).to be_nil
      expect(GymFacade).to have_received(:find_gym).once
    end
  end

  describe 'instance methods' do
    describe '#address and #address_details', :vcr do
      let!(:yelp_gym) { GymFacade.find_gym('gHmS3WIjRRhSWG4OdCQYLA') }
      let(:user) { user_with_gym_membership(yelp_gym_id: yelp_gym.yelp_gym_id) }
      let(:gym_membership) { user.gym_memberships.first }

      it 'can return the address and address details of the gym membership' do
        expect(gym_membership.address).to eq yelp_gym.address
        expect(gym_membership.address_details).to eq yelp_gym.address_details
      end
    end
  end

  describe 'class methods' do
    describe '::gym_member_count', :vcr do
      let!(:yelp_gym) { GymFacade.find_gym('gHmS3WIjRRhSWG4OdCQYLA') }

      context 'when there are no active GymMemberships associated with the Yelp Gym record' do
        it 'can return 0' do
          expect(GymMembership.gym_member_count(yelp_gym.yelp_gym_id)).to eq 0
        end
      end

      context 'when there are active GymMemberships associated with the Yelp Gym record' do
        let(:user) { user_with_gym_membership(yelp_gym_id: yelp_gym.yelp_gym_id) }
        let(:gym_membership) { user.gym_memberships.first }

        it 'can return the number of gym memberships associated with the Yelp Gym record' do
          expect(GymMembership.gym_member_count(gym_membership.yelp_gym_id)).to eq 1
        end
      end
    end
  end
end
