class Event < ApplicationRecord
  belongs_to :user
  belongs_to :gym_membership

  validates :user_id, presence: true, numericality: true
  validates :gym_membership_id, presence: true, numericality: true
  validates :date_time, presence: true
  validates :activity, presence: true

  def host
    user.full_name
  end
end
