FactoryBot.define do
  factory :gym_membership do
    yelp_gym_id { Faker::Alphanumeric.alphanumeric(number: 22) }
    user
  end
end
