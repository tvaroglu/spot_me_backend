class EventSerializer
  include JSONAPI::Serializer

  attributes :user_id, :gym_id, :date_time, :activity
end
