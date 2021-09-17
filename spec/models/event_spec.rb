require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:gym) }
    it { should have_many(:invitations).dependent(:destroy) }
    it { should have_many(:users).through(:invitations) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:user_id) }
    it { should validate_presence_of(:gym_id) }
    it { should validate_numericality_of(:gym_id) }
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

    describe '#event_with_invitation' do
      subject(:event_with_invite) { event_with_invitation }

      it 'is valid with valid attributes' do
        expect(event_with_invite).to be_valid
        expect(event_with_invite.invitations.size).to eq(1)
        expect(event_with_invite.invitations.first).to be_an Invitation
      end
    end
  end
end
