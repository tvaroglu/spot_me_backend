FactoryBot.define do
  factory :gym do
    yelp_gym_id { Faker::Alphanumeric.alphanumeric(number: 22) }
  end
end
