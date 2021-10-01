class Event < ApplicationRecord
  belongs_to :user
  belongs_to :gym_membership

  validates :user_id, presence: true, numericality: true
  validates :gym_membership_id, presence: true, numericality: true
  validates :date_time, presence: true
  validates :activity, presence: true

  def host_name
    gym_membership.user.full_name
  end

  def invited_name
    user.full_name
  end

  def self.upcoming_events
    where('date_time >= ?', Time.zone.now).order(date_time: :desc)
  end

  def self.past_events
    where('date_time < ?', Time.zone.now).order(date_time: :desc)
  end
end
