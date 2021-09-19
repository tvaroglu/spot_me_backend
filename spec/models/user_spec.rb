require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it 'has many followed users' do
      should have_many(:followed_users).with_foreign_key(:follower_id)
                                       .class_name('Friendship')
                                       .dependent(:destroy)
                                       .inverse_of(:follower)
    end

    it { should have_many(:followees).through(:followed_users) }

    it 'has many following users' do
      should have_many(:following_users).with_foreign_key(:followee_id)
                                        .class_name('Friendship')
                                        .dependent(:destroy)
                                        .inverse_of(:followee)
    end

    it { should have_many(:followers).through(:following_users) }

    it { should have_many(:events).dependent(:destroy) }
    it { should have_many(:gym_members).dependent(:destroy) }
    it { should have_many(:invitations).through(:events) }
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
        expect(Friendship.all.size).to eq(5)
        expect(GymMember.all.size).to eq(11)
        expect(Event.all.size).to eq(7)
        expect(Invitation.all.size).to eq(7)
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

    describe '#user_with_gym' do
      subject(:user) { user_with_gym }

      it 'creates valid objects' do
        expect(user).to be_valid
        expect(GymMember.all.size).to eq(1)
        expect(User.all.size).to eq(1)
        expect(user.gym_members.size).to eq(1)
      end
    end

    describe '#user_with_gym_friend' do
      subject(:user) { user_with_gym_friend }

      it 'creates valid objects' do
        expect(user).to be_valid
        expect(Friendship.all.size).to eq(1)
        expect(GymMember.all.size).to eq(2)
        expect(User.all.size).to eq(2)
        expect(user.followees.size).to eq(1)
        expect(user.followers.size).to eq(0)
        expect(user.gym_members.size).to eq(1)
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
      expect(user.goal).to be_an Integer
      expect(user.availability_morning).to be_in([true, false])
      expect(user.availability_afternoon).to be_in([true, false])
      expect(user.availability_evening).to be_in([true, false])
      expect(user.full_name).to be_a String
    end
  end

  describe 'instance methods' do
    describe '#upcoming_events' do
      let(:user) { user_with_gym }
      let(:gym) { user.gym_members.first.yelp_gym_id }

      context 'when there are upcoming events' do
        let!(:past_event) { create(:event, date_time: DateTime.yesterday, user: user, yelp_gym_id: gym) }
        let!(:upcoming_event_1) { create(:event, user: user, yelp_gym_id: gym) }
        let!(:upcoming_event_2) { create(:event, user: user, yelp_gym_id: gym) }
        let!(:upcoming_event_3) { create(:event, user: user, yelp_gym_id: gym) }

        it 'returns the upcoming events for the user' do
          expect(user.upcoming_events).to eq [upcoming_event_1, upcoming_event_2, upcoming_event_3]
        end
      end

      context 'when there are no upcoming events' do
        let!(:past_event) { create(:event, date_time: DateTime.yesterday, user: user, yelp_gym_id: gym) }

        it 'can return an empty array' do
          expect(user.upcoming_events).to be_empty
        end
      end

      context 'when there are no events' do
        it 'can return an empty array' do
          expect(user.upcoming_events).to be_empty
        end
      end
    end
  end
end
