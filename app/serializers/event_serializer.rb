class EventSerializer
  include JSONAPI::Serializer

  attributes :user_id, :gym_membership_id, :date_time, :activity

  belongs_to :user, meta: proc { |event_record| { full_name: event_record.user.full_name } }
end
