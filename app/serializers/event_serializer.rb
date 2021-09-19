class EventSerializer
  include JSONAPI::Serializer

  attributes :user_id, :yelp_gym_id, :date_time, :activity
end
