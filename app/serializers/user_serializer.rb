class UserSerializer
  include JSONAPI::Serializer

  attributes :email, :google_id, :google_token, :google_image_url, :zip_code,
             :summary, :goal, :availability_morning, :availability_afternoon,
             :availability_evening, :first_name, :last_name, :full_name

  # TODO: Add relationships so they can be included in serialized hash
  # has_many :followees
  # has_many :followers
end
