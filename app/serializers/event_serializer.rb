class EventSerializer
  include JSONAPI::Serializer

  attributes :user_id, :gym_membership_id, :date_time, :activity

  meta do |event, params|
    {
      friend_name: params[:current_user] == event.user_id.to_s ? event.host_name : event.invited_name,
      friend_role: params[:current_user] == event.user_id.to_s ? 'host' : 'invited'
    }
  end
end
