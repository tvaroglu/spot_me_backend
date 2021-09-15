class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :google_id, presence: true, uniqueness: true
  validates :google_token, presence: true, uniqueness: true
  validates :google_image_url, presence: true, uniqueness: true
  validates :zip_code, presence: true
  validates :summary, presence: true
  validates :goal, presence: true
  validates :availability_morning, presence: true
  validates :availability_afternoon, presence: true
  validates :availability_evening, presence: true
end
