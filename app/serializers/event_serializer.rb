class EventSerializer
  include JSONAPI::Serializer

  attributes :user_id, :gym_membership_id, :date_time, :activity
end
