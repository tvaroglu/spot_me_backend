class InvitationSerializer
  include JSONAPI::Serializer

  attributes :user_id, :event_id
end
