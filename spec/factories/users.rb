FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    google_id { Faker::Alphanumeric.alphanumeric(number: 21) }
    google_image_url { Faker::Avatar.image }
    zip_code { Faker::Address.zip_code.first(5) }
    summary { Faker::GreekPhilosophers.quote }
    goal { ['Gain Muscle', 'Lose Weight', 'Maintain Weight', 'Increase Flexibility', 'Increase Stamina'].sample }
    availability_morning { [true, false].sample }
    availability_afternoon { [true, false].sample }
    availability_evening { [true, false].sample }
    full_name { Faker::Name.name }
  end
end

def experienced_user
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:user4) { create(:user) }
  let!(:user5) { create(:user) }
  let!(:user6) { create(:user) }
  let!(:user7) { create(:user) }
  let!(:user8) { create(:user) }
  let!(:user9) { create(:user) }

  # Friendship variable naming convention:
  #   ff<follower_user>_<followee_user>
  let!(:ff1_2) { create(:friendship, follower_id: user1.id, followee_id: user2.id) }
  let!(:ff1_3) { create(:friendship, follower_id: user1.id, followee_id: user3.id) }
  let!(:ff1_4) { create(:friendship, follower_id: user1.id, followee_id: user4.id) }
  let!(:ff1_5) { create(:friendship, follower_id: user1.id, followee_id: user5.id) }
  let!(:ff1_6) { create(:friendship, follower_id: user1.id, followee_id: user6.id) }
  let!(:ff2_1) { create(:friendship, follower_id: user2.id, followee_id: user1.id) }

  # Note, real yelp_gym_ids for gym_membership.address and gym_membership.address_details method calls
  let!(:gym1) { 'gHmS3WIjRRhSWG4OdCQYLA' }
  let!(:gym2) { 'yQaElwKOFU865x1jxH3KGw' }
  let!(:gym3) { '77ZmLGWFlgXoGie_p22wvQ' }

  # Gym Member variable naming convention:
  #   gym_mem<user>_<gym>
  let!(:gym_mem1_1) { create(:gym_membership, user: user1, yelp_gym_id: gym1) }
  let!(:gym_mem1_2) { create(:gym_membership, user: user1, yelp_gym_id: gym2) }
  let!(:gym_mem2_1) { create(:gym_membership, user: user2, yelp_gym_id: gym1) }
  let!(:gym_mem2_2) { create(:gym_membership, user: user2, yelp_gym_id: gym2) }
  let!(:gym_mem2_3) { create(:gym_membership, user: user2, yelp_gym_id: gym3) }
  let!(:gym_mem3_1) { create(:gym_membership, user: user3, yelp_gym_id: gym1) }
  let!(:gym_mem3_2) { create(:gym_membership, user: user3, yelp_gym_id: gym2) }
  let!(:gym_mem4_3) { create(:gym_membership, user: user4, yelp_gym_id: gym3) }
  let!(:gym_mem5_1) { create(:gym_membership, user: user5, yelp_gym_id: gym1) }
  let!(:gym_mem5_2) { create(:gym_membership, user: user5, yelp_gym_id: gym2) }
  let!(:gym_mem6_3) { create(:gym_membership, user: user6, yelp_gym_id: gym3) }

  # Event variable naming convention:
  #   event<user>_<gym>_<friend>
  let!(:event1_1a_2) { create(:event, date_time: DateTime.tomorrow, gym_membership: gym_mem1_1, user: user2) }
  let!(:event1_1b_3) { create(:event, date_time: DateTime.tomorrow, gym_membership: gym_mem1_1, user: user3) }
  let!(:event1_1c_5) { create(:event, date_time: DateTime.tomorrow, gym_membership: gym_mem1_1, user: user5) }
  let!(:event1_1d_3) { create(:event, date_time: DateTime.tomorrow, gym_membership: gym_mem1_1, user: user3) }
  let!(:event1_2a_2) { create(:event, date_time: DateTime.tomorrow, gym_membership: gym_mem1_2, user: user2) }
  let!(:event1_2b_5) { create(:event, date_time: DateTime.tomorrow, gym_membership: gym_mem1_2, user: user5) }
  let!(:event1_2c_3) { create(:event, date_time: DateTime.tomorrow, gym_membership: gym_mem1_2, user: user3) }
end

def user_with_friend
  FactoryBot.create(:user) do |user1|
    FactoryBot.create(:user) do |user2|
      FactoryBot.create(:friendship, follower_id: user1.id, followee_id: user2.id)
    end
  end
end

def user_with_gym_friend
  FactoryBot.create(:user) do |user1|
    FactoryBot.create(:user) do |user2|
      FactoryBot.create(:gym_membership, yelp_gym_id: 'c2jzsndq8brvn9fbckeec2', user: user1)
      FactoryBot.create(:gym_membership, yelp_gym_id: 'c2jzsndq8brvn9fbckeec2', user: user2)
      FactoryBot.create(:friendship, follower_id: user1.id, followee_id: user2.id)
    end
  end
end

def user_with_gym_membership(yelp_gym_id: 'c2jzsndq8brvn9fbckeec2')
  FactoryBot.create(:user) do |user|
    FactoryBot.create(:gym_membership, yelp_gym_id: yelp_gym_id, user: user)
  end
end
