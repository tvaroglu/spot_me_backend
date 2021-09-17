class InvitationSerializer
  include JSONAPI::Serializer

  attributes :user_id, :event_id
  #
  # belongs_to :event
  # belongs_to :user
end
