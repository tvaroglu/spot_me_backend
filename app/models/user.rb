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

  delegate :upcoming_events, :past_events, to: :events, prefix: :hosted
  delegate :upcoming_events, :past_events, to: :invited_events, prefix: :invited

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

  def all_upcoming_events
    hosted_upcoming_events + invited_upcoming_events
  end

  def all_past_events
    hosted_past_events + invited_past_events
  end

  def followees_at_same_gym(yelp_gym_id)
    # users that the current user IS following at the same gym
    followees.users_at_same_gym(yelp_gym_id)
  end

  def followers_at_same_gym(yelp_gym_id)
    # users that are following the current user at the same gym
    followers.users_at_same_gym(yelp_gym_id)
  end

  def non_followees_at_same_gym(yelp_gym_id)
    # users that the current user is NOT following at the same gym
    User.users_at_same_gym(yelp_gym_id) -
      followees_at_same_gym(yelp_gym_id) -
      [self]
  end

  def non_followers_at_same_gym(yelp_gym_id)
    # users that are not following the current user at the same gym
    User.users_at_same_gym(yelp_gym_id) -
      followers_at_same_gym(yelp_gym_id) -
      [self]
  end

  def self.users_at_same_gym(yelp_gym_id)
    joins(:gym_memberships)
      .where(gym_memberships: { yelp_gym_id: yelp_gym_id })
  end
end
