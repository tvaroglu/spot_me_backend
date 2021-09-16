class Event < ApplicationRecord
  belongs_to :user
  belongs_to :gym

  has_many :invitations, dependent: :destroy
  has_many :users, through: :invitations

  validates :user_id, presence: true, numericality: true
  validates :gym_id, presence: true, numericality: true
  validates :date_time, presence: true
  validates :activity, presence: true

  # do we want to keep events restful?
  def self.future_events
    # look into lamdas and strftime
    # where("events.date_time >= ?", DateTime.now)
  end
end
