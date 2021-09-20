# require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

Friendship.destroy_all
GymMembership.destroy_all
Event.destroy_all
User.destroy_all

# reset PK's
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

# USERS
user1 = create(:user, availability_morning: true)
user2 = create(:user, availability_morning: true) # no followers # no events
user3 = create(:user, availability_morning: true, availability_afternoon: true)
user4 = create(:user, availability_morning: true, availability_afternoon: true) # no followees
user5 = create(:user, availability_morning: true, availability_afternoon: true) # no events # no invitations
user6 = create(:user, availability_morning: true, availability_evening: true) # no invitations
user7 = create(:user, availability_evening: true)
user8 = create(:user, availability_morning: true, availability_afternoon: true, availability_evening: true) # no events
user9 = create(:user, availability_afternoon: true, availability_evening: true) # no invitations
user10 = create(:user, availability_evening: true) # no gym membership # no events # no invitations

# GYMS
gym1 = 'lex65fkcol5gfq89rymmd2'
gym2 = 'gekb7mgqksbwyfqjz5x6fd' # only one gym member
gym3 = '6x10s0lbnry4ivkzcjpilk'
gym4 = 'yfsp4c59p3wrlplrn1rf7r'
gym5 = 'wxaw9m796t6wdnsk53uieh'

# GYM MEMBERS
gym_member1 = create(:gym_membership, user: user1, yelp_gym_id: gym1)
gym_member2 = create(:gym_membership, user: user3, yelp_gym_id: gym1)
gym_member3 = create(:gym_membership, user: user4, yelp_gym_id: gym1)
gym_member4 = create(:gym_membership, user: user7, yelp_gym_id: gym1)
gym_member5 = create(:gym_membership, user: user9, yelp_gym_id: gym1)

gym_member6 = create(:gym_membership, user: user4, yelp_gym_id: gym2) # only 1 member

gym_member7 = create(:gym_membership, user: user1, yelp_gym_id: gym3)
gym_member8 = create(:gym_membership, user: user5, yelp_gym_id: gym3)
gym_member9 = create(:gym_membership, user: user7, yelp_gym_id: gym3)
gym_member10 = create(:gym_membership, user: user10, yelp_gym_id: gym3)

gym_member11 = create(:gym_membership, user: user2, yelp_gym_id: gym4)
gym_member12 = create(:gym_membership, user: user3, yelp_gym_id: gym4)
gym_member13 = create(:gym_membership, user: user6, yelp_gym_id: gym4)
gym_member14 = create(:gym_membership, user: user7, yelp_gym_id: gym4)
#gym_member15 :(
gym_member16 = create(:gym_membership, user: user8, yelp_gym_id: gym4)
gym_member17 = create(:gym_membership, user: user9, yelp_gym_id: gym4)

gym_member18 = create(:gym_membership, user: user1, yelp_gym_id: gym5)
gym_member19 = create(:gym_membership, user: user2, yelp_gym_id: gym5)
gym_member20 = create(:gym_membership, user: user5, yelp_gym_id: gym5)

# FRIENDSHIPS
friendship1 = create(:friendship, follower: user1, followee: user3)
friendship2 = create(:friendship, follower: user1, followee: user9)
friendship3 = create(:friendship, follower: user1, followee: user10)
friendship4 = create(:friendship, follower: user3, followee: user1)
friendship5 = create(:friendship, follower: user4, followee: user7)
friendship6 = create(:friendship, follower: user4, followee: user8)
friendship7 = create(:friendship, follower: user5, followee: user6)
friendship8 = create(:friendship, follower: user6, followee: user2)
friendship9 = create(:friendship, follower: user6, followee: user10)
friendship10 = create(:friendship, follower: user7, followee: user1)
friendship11 = create(:friendship, follower: user7, followee: user6)
friendship12 = create(:friendship, follower: user7, followee: user9)
friendship13 = create(:friendship, follower: user7, followee: user10)
friendship14 = create(:friendship, follower: user8, followee: user2)
friendship15 = create(:friendship, follower: user8, followee: user3)
friendship16 = create(:friendship, follower: user9, followee: user5)
friendship17 = create(:friendship, follower: user9, followee: user6)
friendship18 = create(:friendship, follower: user9, followee: user8)
friendship19 = create(:friendship, follower: user9, followee: user10)
friendship20 = create(:friendship, follower: user10, followee: user3)

# EVENTS (user is the 'host')
event1 = create(:event, user: user3, gym_membership: gym_member1)
event2 = create(:event, user: user4, gym_membership: gym_member1)
event3 = create(:event, user: user7, gym_membership: gym_member7)
event4 = create(:event, user: user1, gym_membership: gym_member2)
event5 = create(:event, user: user6, gym_membership: gym_member12)
event6 = create(:event, user: user1, gym_membership: gym_member20)
event7 = create(:event, user: user2, gym_membership: gym_member20)
event8 = create(:event, user: user1, gym_membership: gym_member20)
event9 = create(:event, user: user2, gym_membership: gym_member13)
event10 = create(:event, user: user1, gym_membership: gym_member4)
event11 = create(:event, user: user6, gym_membership: gym_member16)
event12 = create(:event, user: user7, gym_membership: gym_member16)
event13 = create(:event, user: user7, gym_membership: gym_member5)
event14 = create(:event, user: user7, gym_membership: gym_member5)
event15 = create(:event, user: user6, gym_membership: gym_member17)
