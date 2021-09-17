class EventSerializer
  include JSONAPI::Serializer

  attributes :user_id, :gym_id, :date_time, :activity

  belongs_to :user
  belongs_to :gym

  has_many :invitations
end
