class FriendshipSerializer
  include JSONAPI::Serializer

  attributes :follower_id, :followee_id
end
