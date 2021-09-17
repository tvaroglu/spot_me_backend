FactoryBot.define do
  factory :friendship do
    follower_id { create(:user).id }
    followee_id { create(:user).id }
  end
end
