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

  describe 'delegations' do
    describe '#address and #address_details' do
      it { should delegate_method(:address).to(:find_gym) }
      it { should delegate_method(:address_details).to(:find_gym) }
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
end
