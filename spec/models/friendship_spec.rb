require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'relationships' do
    it { should belong_to(:followee).class_name('User') }
    it { should belong_to(:follower).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:followee_id) }
    it { should validate_numericality_of(:followee_id) }
    it { should validate_presence_of(:follower_id) }
    it { should validate_numericality_of(:follower_id) }
    it { should validate_uniqueness_of(:followee_id).scoped_to(:follower_id) }
  end

  describe 'factories' do
    describe 'friendship' do
      it 'is valid with valid attributes' do
        friendship = create(:friendship)
        expect(friendship).to be_valid
      end
    end
  end
end
