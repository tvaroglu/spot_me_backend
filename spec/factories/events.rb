FactoryBot.define do
  factory :event do
    date_time { DateTime.now }
    activity { Faker::Hobby.activity }
    user
    gym
  end
end
