FactoryBot.define do
  factory :event do
    activity { Faker::Hobby.activity }
    date_time { DateTime.now + rand(1..10).days }
    yelp_gym_id { Faker::Alphanumeric.alphanumeric(number: 22) }
    user
  end
end

def event_with_invitation
  FactoryBot.create(:event) do |event|
    FactoryBot.create(:invitation, event: event)
  end
end
