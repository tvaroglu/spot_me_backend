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
