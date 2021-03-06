require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it 'has many followed users' do
      expect(subject).to have_many(:followed_users).with_foreign_key(:follower_id)
                                                   .class_name('Friendship')
                                                   .dependent(:destroy)
                                                   .inverse_of(:follower)
    end

    it { should have_many(:followees).through(:followed_users) }

    it 'has many following users' do
      expect(subject).to have_many(:following_users).with_foreign_key(:followee_id)
                                                    .class_name('Friendship')
                                                    .dependent(:destroy)
                                                    .inverse_of(:followee)
    end

    it { should have_many(:followers).through(:following_users) }

    it { should have_many(:events).through(:gym_memberships) }
    it { should have_many(:gym_memberships).dependent(:destroy) }
    it { should have_many(:invited_events).class_name('Event').dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:google_id) }
    it { should validate_uniqueness_of(:google_id) }
    it { should validate_presence_of(:google_image_url) }
    it { should validate_uniqueness_of(:google_image_url) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
    it { should validate_presence_of(:summary) }
    it { should validate_presence_of(:goal) }
    it { should define_enum_for(:goal).with_values(['Gain Muscle', 'Lose Weight', 'Maintain Weight', 'Increase Flexibility', 'Increase Stamina']) }
    it { should validate_presence_of(:full_name) }
  end

  describe 'factories' do
    describe 'user' do
      subject(:user) { create(:user) }

      it 'is valid with valid attributes' do
        expect(user).to be_valid
      end
    end

    describe '#experienced_user' do
      experienced_user

      it 'creates valid objects' do
        expect(User.all.size).to eq(9)
        expect(Friendship.all.size).to eq(6)
        expect(GymMembership.all.size).to eq(11)
        expect(Event.all.size).to eq(7)
      end
    end

    describe '#user_with_friend' do
      subject(:user) { user_with_friend }

      it 'creates valid objects' do
        expect(user).to be_valid
        expect(user.followees.size).to eq(1)
        expect(user.followers.size).to eq(0)
        expect(User.all.size).to eq(2)
        expect(Friendship.all.size).to eq(1)
      end
    end

    describe '#user_with_gym_membership' do
      context 'when I do not provide a yelp_gym_id' do
        subject(:user) { user_with_gym_membership }

        it 'creates valid objects with a default yelp_gym_id' do
          expect(user).to be_valid
          expect(GymMembership.all.size).to eq(1)
          expect(User.all.size).to eq(1)
          expect(user.gym_memberships.size).to eq(1)
          expect(user.gym_memberships.first.yelp_gym_id).to eq('c2jzsndq8brvn9fbckeec2')
        end
      end

      context 'when I do provide a yelp_gym_id' do
        subject(:user) { user_with_gym_membership(yelp_gym_id: 'fvdr0ksvy2nhith42ffur2') }

        it 'creates valid objects with the provided yelp_gym_id' do
          expect(user).to be_valid
          expect(GymMembership.all.size).to eq(1)
          expect(User.all.size).to eq(1)
          expect(user.gym_memberships.size).to eq(1)
          expect(user.gym_memberships.first.yelp_gym_id).to eq('fvdr0ksvy2nhith42ffur2')
        end
      end
    end

    describe '#user_with_gym_friend' do
      subject(:user) { user_with_gym_friend }

      it 'creates valid objects' do
        expect(user).to be_valid
        expect(Friendship.all.size).to eq(1)
        expect(GymMembership.all.size).to eq(2)
        expect(User.all.size).to eq(2)
        expect(user.followees.size).to eq(1)
        expect(user.followers.size).to eq(0)
        expect(user.gym_memberships.size).to eq(1)
      end
    end
  end

  describe 'attributes' do
    subject(:user) { create(:user) }

    it 'has readable attributes' do
      expect(user.email).to be_a String
      expect(user.google_id).to be_a String
      expect(user.google_image_url).to be_a String
      expect(user.zip_code).to be_a String
      expect(user.summary).to be_a String
      expect(user.goal).to be_a String
      expect(user.availability_morning).to be_in([true, false])
      expect(user.availability_afternoon).to be_in([true, false])
      expect(user.availability_evening).to be_in([true, false])
      expect(user.full_name).to be_a String
    end
  end

  describe 'delegations' do
    describe '#upcoming_events and #past_events' do
      it { should delegate_method(:upcoming_events).to(:events).with_prefix(:hosted) }
      it { should delegate_method(:past_events).to(:events).with_prefix(:hosted) }
      it { should delegate_method(:upcoming_events).to(:invited_events).with_prefix(:invited) }
      it { should delegate_method(:past_events).to(:invited_events).with_prefix(:invited) }
    end
  end

  describe 'instance methods' do
    describe '#all_upcoming_events and #all_past_events' do
      let!(:user1) { user_with_gym_membership }
      let!(:user2) { user_with_gym_membership }
      let!(:gym_id) { user1.gym_memberships.first.id }

      context 'when there are upcoming and past events' do
        let!(:past_event_1) { create(:event, date_time: DateTime.yesterday - 1, user_id: user2.id, gym_membership_id: gym_id) }
        let!(:past_event_2) { create(:event, date_time: DateTime.yesterday - 2, user_id: user2.id, gym_membership_id: gym_id) }
        let!(:upcoming_event_1) { create(:event, date_time: DateTime.tomorrow + 1, user_id: user2.id, gym_membership_id: gym_id) }
        let!(:upcoming_event_2) { create(:event, date_time: DateTime.tomorrow + 2, user_id: user2.id, gym_membership_id: gym_id) }
        let!(:upcoming_event_3) { create(:event, date_time: DateTime.tomorrow + 3, user_id: user2.id, gym_membership_id: gym_id) }

        it 'returns the upcoming events for the user in ascending order' do
          expect(user1.all_upcoming_events).to eq [upcoming_event_1, upcoming_event_2, upcoming_event_3]
        end

        it 'returns the past events for the user in descending order' do
          expect(user1.all_past_events).to eq [past_event_1, past_event_2]
        end

        it 'returns the upcoming events the user has been invited to' do
          expect(user2.all_upcoming_events).to eq user1.all_upcoming_events
        end

        it 'returns the past events the user was invited to' do
          expect(user2.all_past_events).to eq user1.all_past_events
        end
      end

      context 'when there are no upcoming events' do
        let!(:past_event) { create(:event, date_time: DateTime.yesterday, user: user2, gym_membership_id: gym_id) }

        it 'can return an empty array' do
          expect(user1.all_upcoming_events).to be_empty
          expect(user2.all_upcoming_events).to be_empty
        end
      end

      context 'when there are no past events' do
        let!(:upcoming_event) { create(:event, date_time: DateTime.tomorrow, user: user2, gym_membership_id: gym_id) }

        it 'can return an empty array' do
          expect(user1.all_past_events).to be_empty
          expect(user2.all_past_events).to be_empty
        end
      end

      context 'when there are no events' do
        it 'can return an empty array' do
          expect(user1.all_upcoming_events).to be_empty
          expect(user1.all_past_events).to be_empty
          expect(user2.all_upcoming_events).to be_empty
          expect(user2.all_past_events).to be_empty
        end
      end
    end

    describe '#followees_at_same_gym' do
      let!(:user1) { user_with_gym_friend }
      let!(:user2) { user1.followees.first }
      let!(:yelp_gym_id) { user1.gym_memberships.first.yelp_gym_id }

      context 'when the user has a followee (is following a user)' do
        it "returns the user's followees from the shared gym" do
          expected = user1.followees_at_same_gym(yelp_gym_id)

          expect(expected.length).to eq 1
          expect(expected.first).to eq user2
        end
      end

      context "when the user doesn't have a followee (is not following any users)" do
        it 'returns an empty array' do
          expected = user2.followees_at_same_gym(yelp_gym_id)

          expect(expected).to be_empty
        end
      end
    end

    describe '#followers_at_same_gym' do
      let!(:user1) { user_with_gym_friend }
      let!(:user2) { user1.followees.first }
      let!(:yelp_gym_id) { user1.gym_memberships.first.yelp_gym_id }

      context 'when the user has a follower (is followed by a user)' do
        it "returns the user's followers from the shared gym" do
          expected = user2.followers_at_same_gym(yelp_gym_id)

          expect(expected.length).to eq 1
          expect(expected.first).to eq user1
        end
      end

      context "when the user doesn't have a follower (is not followed by any users)" do
        it 'returns an empty array' do
          expected = user1.followers_at_same_gym(yelp_gym_id)

          expect(expected).to be_empty
        end
      end
    end

    describe '#non_followees_at_same_gym' do
      context 'when the user is not following a user at the same gym' do
        let!(:user1) { user_with_gym_friend }
        let!(:yelp_gym_id) { user1.gym_memberships.first.yelp_gym_id }
        let!(:user2) { create(:user) }
        let!(:gym_membership) { create(:gym_membership, user: user2, yelp_gym_id: yelp_gym_id) }

        it 'returns the user from the shared gym' do
          expected = user1.non_followees_at_same_gym(yelp_gym_id)

          expect(expected.length).to eq 1
          expect(expected.first).to eq user2
        end
      end

      context 'when the user is already following everyone at the gym' do
        let!(:user1) { user_with_gym_friend }
        let!(:yelp_gym_id) { user1.gym_memberships.first.yelp_gym_id }

        it 'returns an empty array' do
          expected = user1.non_followees_at_same_gym(yelp_gym_id)

          expect(expected).to be_empty
        end
      end
    end

    describe '#non_followers_at_same_gym' do
      context 'when the user is not followed by a user at the same gym' do
        let!(:user1) { user_with_gym_friend }
        let!(:yelp_gym_id) { user1.gym_memberships.first.yelp_gym_id }
        let!(:user2) { create(:user) }
        let!(:gym_membership) { create(:gym_membership, user: user2, yelp_gym_id: yelp_gym_id) }

        it 'returns the user from the shared gym' do
          expected = user1.non_followers_at_same_gym(yelp_gym_id)

          expect(expected.length).to eq 2
          expect(expected.first).to eq user1.followees.first
          expect(expected.second).to eq user2
        end
      end

      context 'when the user is already followed by everyone at the gym' do
        let!(:user1) { user_with_gym_friend }
        let!(:user2) { user1.followees.first }
        let!(:yelp_gym_id) { user1.gym_memberships.first.yelp_gym_id }

        it 'returns an empty array' do
          expected = user2.non_followers_at_same_gym(yelp_gym_id)

          expect(expected).to be_empty
        end
      end
    end
  end

  describe 'class methods' do
    describe '::users_at_same_gym' do
      let!(:user1) { user_with_gym_membership }
      let!(:yelp_gym_id) { user1.gym_memberships.first.yelp_gym_id }

      context 'when there are multiple users at the same gym' do
        let!(:user2) { create(:user) }
        let!(:shared_gym) { create(:gym_membership, user_id: user2.id, yelp_gym_id: yelp_gym_id) }

        it 'returns the users that belong to the same gym' do
          expected = User.users_at_same_gym(yelp_gym_id)

          expect(expected.length).to eq 2
          expect(expected.first).to eq user1
          expect(expected.last).to eq user2
        end
      end

      context 'when there are not multiple users at the same gym' do
        let!(:user2) { create(:user) }
        let!(:other_gym) { create(:gym_membership, user_id: user2.id) }

        it 'only returns the users that belong to the same gym' do
          expected = User.users_at_same_gym(yelp_gym_id)

          expect(expected.length).to eq 1
          expect(expected.first).to eq user1
        end
      end
    end
  end
end
