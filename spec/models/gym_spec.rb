require 'rails_helper'

RSpec.describe Gym, type: :model do
  describe 'relationships' do
    it { should have_many(:gym_members) }
    it { should have_many(:users).through(:gym_members) }
    it { should have_many(:events) }
  end

  describe 'validations' do
    it { should validate_presence_of(:yelp_gym_id) }
  end
  #
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
