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
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:google_id) }
    it { should validate_uniqueness_of(:google_id) }
    it { should validate_presence_of(:google_token) }
    it { should validate_uniqueness_of(:google_token) }
    it { should validate_presence_of(:google_image_url) }
    it { should validate_uniqueness_of(:google_image_url) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
    it { should validate_presence_of(:summary) }
    it { should validate_presence_of(:goal) }
    it { should validate_presence_of(:availability_morning) }
    it { should validate_presence_of(:availability_afternoon) }
    it { should validate_presence_of(:availability_evening) }
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
