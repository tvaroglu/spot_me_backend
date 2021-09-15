class Friendship < ApplicationRecord
  belongs_to :followee, class_name: 'User'
  belongs_to :follower, class_name: 'User'

  validates :followee_id, presence: true,
                          numericality: true,
                          uniqueness: { scope: :follower_id }
  validates :follower_id, presence: true, numericality: true
end
