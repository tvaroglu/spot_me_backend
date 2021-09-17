class UserSerializer
  include JSONAPI::Serializer

  attributes :email, :google_id, :google_image_url, :zip_code, :summary, :goal,
             :availability_morning, :availability_afternoon,
             :availability_evening, :full_name

  # TODO: Add relationships so they can be included in serialized hash
  # has_many :gyms
  # has_many :events
  #
  # meta do |user|
  #   user.followees.map do |followee|
  #     {
  #       friend_id: followee.id,
  #       friend_name: followee.full_name,
  #     }
  #   end
  # end
end
