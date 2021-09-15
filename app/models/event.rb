class Event < ApplicationRecord
  validates :user_id, presence: true
  validates :gym_id, presence: true
  validates :date_time, presence: true
  validates :activity, presence: true

  belongs_to :user
  belongs_to :gym
end
