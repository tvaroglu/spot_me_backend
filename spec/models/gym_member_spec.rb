require 'rails_helper'

RSpec.describe GymMember, type: :model do
  describe 'relationships' do
    it { should belong_to(:gym) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:user_id) }
    it { should validate_presence_of(:gym_id) }
    it { should validate_numericality_of(:gym_id) }
  end

  describe 'factories' do
    describe 'gym member' do
      it 'is valid with valid attributes' do
        gym_member = create(:gym_member)
        expect(gym_member).to be_valid
      end
    end
  end

  # before :each do
  #
  # end
  #
  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
  #
  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end
end
