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
    describe '#host' do
      let(:user) { user_with_gym_membership }
      let(:gym_id) { user.gym_memberships.first.id }
      let(:event) { create(:event, user: user, gym_membership_id: gym_id) }

      it 'can return the full name of the user hosting the event' do
        expect(event.host).to eq user.full_name
      end
    end
  end
end
