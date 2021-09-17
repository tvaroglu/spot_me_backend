require 'rails_helper'

RSpec.describe Gym, type: :model do
  describe 'relationships' do
    it { should have_many(:events).dependent(:destroy) }
    it { should have_many(:gym_members).dependent(:destroy) }
    it { should have_many(:users).through(:gym_members) }
  end

  describe 'validations' do
    it { should validate_presence_of(:yelp_gym_id) }
  end

  describe 'factories' do
    describe 'gym' do
      it 'is valid with valid attributes' do
        gym = create(:gym)
        expect(gym).to be_valid
      end
    end
  end
end
