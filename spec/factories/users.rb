FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    google_id { Faker::Alphanumeric.alphanumeric(number: 10) } # Update with same number of characters as id
    google_token { Faker::Alphanumeric.alphanumeric(number: 10) } # Update with same number of characters as token
    google_image_url { Faker::Avatar.image }
    zip_code { Faker::Address.zip_code.first(5) }
    summary { Faker::GreekPhilosophers.quote }
    goal { rand(0..5) }
    availability_morning { [true, false].sample }
    availability_afternoon { [true, false].sample }
    availability_evening { [true, false].sample }
  end
end
