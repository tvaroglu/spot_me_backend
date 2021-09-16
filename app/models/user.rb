class User < ApplicationRecord
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Friendship',
                            dependent: :destroy, inverse_of: :follower
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Friendship',
                             dependent: :destroy, inverse_of: :followee
  has_many :followers, through: :following_users

  validates :email, presence: true, uniqueness: true
  validates :google_id, presence: true, uniqueness: true
  validates :google_token, presence: true, uniqueness: true
  validates :google_image_url, presence: true, uniqueness: true
  validates :zip_code, presence: true, numericality: true
  validates :summary, presence: true
  validates :goal, presence: true
  validates :availability_morning, inclusion: { in: [true, false] }
  validates :availability_afternoon, inclusion: { in: [true, false] }
  validates :availability_evening, inclusion: { in: [true, false] }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :full_name, presence: true
end
