class EventSerializer
  include JSONAPI::Serializer

  attributes :user_id, :gym_membership_id, :date_time, :activity

  belongs_to :user, meta: Proc.new { |event_record, params|
    { full_name: event_record.user.full_name }
  }
end
