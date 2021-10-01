class User < ApplicationRecord
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Friendship',
                            dependent: :destroy, inverse_of: :follower
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id,
                             class_name: 'Friendship', dependent: :destroy,
                             inverse_of: :followee
  has_many :followers, through: :following_users

  has_many :invited_events, class_name: 'Event', dependent: :destroy
  has_many :gym_memberships, dependent: :destroy
  has_many :events, through: :gym_memberships

  validates :email, presence: true, uniqueness: true
  validates :google_id, presence: true, uniqueness: true
  validates :google_image_url, presence: true, uniqueness: true
  validates :zip_code, presence: true, numericality: true

  validates :summary, presence: true
  validates :goal, presence: true
  validates :availability_morning, inclusion: { in: [true, false] }
  validates :availability_afternoon, inclusion: { in: [true, false] }
  validates :availability_evening, inclusion: { in: [true, false] }
  validates :full_name, presence: true

  enum goal: { 'Gain Muscle' => 0, 'Lose Weight' => 1, 'Maintain Weight' => 2,
               'Increase Flexibility' => 3, 'Increase Stamina' => 4 }

  def upcoming_events(invitee_id = nil)
    hosted = events.where('date_time >= ?', Time.zone.now)
                   .order(date_time: :desc)
    return hosted if invitee_id.nil?

    invited = Event.where('date_time >= ?', Time.zone.now)
                   .where(user_id: invitee_id)
                   .order(date_time: :desc)
    (hosted + invited).uniq
  end

  def past_events(invitee_id = nil)
    hosted = events.where('date_time < ?', Time.zone.now)
                   .order(date_time: :desc)
    return hosted if invitee_id.nil?

    invited = Event.where('date_time < ?', Time.zone.now)
                   .where(user_id: invitee_id)
                   .order(date_time: :desc)
    (hosted + invited).uniq
  end

  def friends_at_same_gym(yelp_gym_id)
    followees.users_at_same_gym(yelp_gym_id)
  end

  def non_friends_at_same_gym(yelp_gym_id)
    User.users_at_same_gym(yelp_gym_id) -
      friends_at_same_gym(yelp_gym_id) -
      [self]
  end

  def self.users_at_same_gym(yelp_gym_id)
    joins(:gym_memberships)
      .where(gym_memberships: { yelp_gym_id: yelp_gym_id })
  end
end
