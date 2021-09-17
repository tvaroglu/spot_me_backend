require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:followed_users).with_foreign_key(:follower_id)
                                          .class_name('Friendship')
                                          .dependent(:destroy)
                                          .inverse_of(:follower) }

    it { should have_many(:followees).through(:followed_users) }
    it { should have_many(:following_users).with_foreign_key(:followee_id)
                                           .class_name('Friendship')
                                           .dependent(:destroy)
                                           .inverse_of(:followee) }

    it { should have_many(:followers).through(:following_users) }
    it { should have_many(:events).dependent(:destroy) }
    it { should have_many(:gym_members).dependent(:destroy) }
    it { should have_many(:invitations).through(:events) }
    it { should have_many(:gyms).through(:gym_members) }
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
end
