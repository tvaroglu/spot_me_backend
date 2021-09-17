class UserSerializer
  include JSONAPI::Serializer

  attributes :email, :google_id, :google_image_url, :zip_code, :summary, :goal,
             :availability_morning, :availability_afternoon,
             :availability_evening, :full_name
end
