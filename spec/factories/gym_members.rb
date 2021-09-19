FactoryBot.define do
  factory :gym_member do
    yelp_gym_id { Faker::Alphanumeric.alphanumeric(number: 22) }
    user
  end
end
