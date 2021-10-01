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

  describe 'class methods' do
    describe '::upcoming_invited_events and ::upcoming_past_events' do
      let!(:user1) { user_with_gym_membership }
      let!(:user2) { user_with_gym_membership }
      let!(:gym_id) { user1.gym_memberships.first.id }

      context 'when there are upcoming events' do
        let!(:past_event) { create(:event, date_time: DateTime.yesterday, user_id: user2.id, gym_membership_id: gym_id) }
        let!(:upcoming_event_1) { create(:event, date_time: DateTime.tomorrow, user_id: user2.id, gym_membership_id: gym_id) }
        let!(:upcoming_event_2) { create(:event, date_time: DateTime.tomorrow, user_id: user2.id, gym_membership_id: gym_id) }
        let!(:upcoming_event_3) { create(:event, date_time: DateTime.tomorrow, user_id: user2.id, gym_membership_id: gym_id) }

        it 'returns the upcoming events' do
          expect(Event.upcoming_events.first).to eq upcoming_event_1
          expect(Event.upcoming_events.second).to eq upcoming_event_2
          expect(Event.upcoming_events.third).to eq upcoming_event_3
        end

        it 'returns the past events' do
          expect(Event.past_events.first).to eq past_event
        end
      end

      context 'when there are no upcoming events' do
        let!(:past_event) { create(:event, date_time: DateTime.yesterday, user: user2, gym_membership_id: gym_id) }

        it 'can return an empty array' do
          expect(Event.upcoming_events).to be_empty
        end
      end

      context 'when there are no past events' do
        let!(:upcoming_event) { create(:event, date_time: DateTime.tomorrow, user: user2, gym_membership_id: gym_id) }

        it 'can return an empty array' do
          expect(Event.past_events).to be_empty
        end
      end

      context 'when there are no events' do
        it 'can return an empty array' do
          expect(Event.upcoming_events).to be_empty
          expect(Event.past_events).to be_empty
        end
      end
    end
  end
end
