require 'rails_helper'

RSpec.describe Event, type: :model do
  # describe 'relationships' do
  #   it { should belong_to(:) }
  #   it { should have_many(:) }
  #   it { should have_many(:).through(:) }
  # end
  #
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:gym_id) }
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
