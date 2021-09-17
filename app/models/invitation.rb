class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event_id, presence: true, numericality: true
  validates :user_id, presence: true, numericality: true
end
