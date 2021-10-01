require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:gym_membership) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:user_id) }
    it { should validate_presence_of(:gym_membership_id) }
    it { should validate_numericality_of(:gym_membership_id) }
    it { should validate_presence_of(:date_time) }
    it { should validate_presence_of(:activity) }
  end

  describe 'factories' do
    describe 'event' do
      subject(:event) { create(:event) }

      it 'is valid with valid attributes' do
        expect(event).to be_valid
      end
    end
  end

  describe 'instance methods' do
    describe '#host_name and #invited_name' do
      let!(:user1) { user_with_gym_friend }
      let(:user2) { User.last }
      let(:gym_membership1) { create(:gym_membership, user: user1) }
      let(:gym_membership2) { create(:gym_membership, user: user2, yelp_gym_id: gym_id) }
      let(:gym_id) { user1.gym_memberships.first.yelp_gym_id }
      let(:event) { create(:event, user: user2, gym_membership: gym_membership1) }

      it 'can return the full names of the user hosting and the user invited to the event' do
        expect(event.host_name).to eq user1.full_name
        expect(event.invited_name).to eq user2.full_name
      end
    end
  end
end
