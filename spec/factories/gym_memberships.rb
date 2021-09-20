FactoryBot.define do
  factory :gym_membership do
    yelp_gym_id { Faker::Alphanumeric.alphanumeric(number: 22) }
    gym_name { Faker::Company.name }
    user
  end
end
