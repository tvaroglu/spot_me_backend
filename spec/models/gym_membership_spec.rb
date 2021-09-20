require 'rails_helper'

RSpec.describe GymMembership, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:events) }
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
end
