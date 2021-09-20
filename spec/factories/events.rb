FactoryBot.define do
  factory :event do
    activity { Faker::Hobby.activity }
    date_time { DateTime.now + rand(1..10).days }
    user
    gym_membership
  end
end
