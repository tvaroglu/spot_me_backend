class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :google_id, presence: true, uniqueness: true
  validates :google_token, presence: true, uniqueness: true
  validates :google_image_url, presence: true, uniqueness: true
  validates :zip_code, presence: true
  validates :summary, presence: true
  validates :goal, presence: true
  validates :availability_morning, inclusion: { in: [true, false] }
  validates :availability_afternoon, inclusion: { in: [true, false] }
  validates :availability_evening, inclusion: { in: [true, false] }
end
