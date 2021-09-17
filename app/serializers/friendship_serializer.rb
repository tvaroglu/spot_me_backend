class FriendshipSerializer
  include JSONAPI::Serializer

  attributes :follower_id, :followee_id
  # 
  # belongs_to :followee, record_typ: :user
  # belongs_to :follower, record_typ: :user
end
