require 'rails_helper'

RSpec.describe Invitation, type: :model do
  describe 'relationships' do
    it { should belong_to(:event) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:user_id) }
    it { should validate_presence_of(:event_id) }
    it { should validate_numericality_of(:event_id) }
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
