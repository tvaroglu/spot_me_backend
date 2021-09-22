class EventSerializer
  include JSONAPI::Serializer

  attributes :user_id, :gym_membership_id, :date_time, :activity

  belongs_to :user, meta: proc { |event| { full_name: event.user.full_name } }
end
