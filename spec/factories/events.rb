FactoryBot.define do
  factory :event do
    date_time { DateTime.now }
    activity { Faker::Hobby.activity }
    user
    gym
  end
end

def event_with_invitation
  FactoryBot.create(:event) do |event|
    FactoryBot.create(:invitation, event: event)
  end
end
