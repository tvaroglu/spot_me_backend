# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# USERS
user1 = create(:user, availability_morning: true)
user2 = create(:user, availability_morning: true) # no followers # no events
user3 = create(:user, availability_morning: true, availability_afternoon: true)
user4 = create(:user, availability_morning: true, availability_afternoon: true) # no followees
user5 = create(:user, availability_morning: true, availability_afternoon: true) # no events
user6 = create(:user, availability_morning: true, availability_evening: true)
user7 = create(:user, availability_evening: true)
user8 = create(:user, availability_morning: true, availability_morning: true, availability_evening: true) # no events
user9 = create(:user, availability_afternoon: true, availability_evening: true)
user10 = create(:user, availability_evening: true) # no gym membership

# GYMS
gym1 = create(:gym)
gym2 = create(:gym) # only one gym member
gym3 = create(:gym)
gym4 = create(:gym)
gym5 = create(:gym)

# GYM MEMBERS
gym_member1 = create(:gym_member, user: user1, gym: gym1)
gym_member2 = create(:gym_member, user: user3, gym: gym1)
gym_member3 = create(:gym_member, user: user4, gym: gym1)
gym_member4 = create(:gym_member, user: user7, gym: gym1)
gym_member5 = create(:gym_member, user: user9, gym: gym1)

gym_member6 = create(:gym_member, user: user4, gym: gym2)

gym_member7 = create(:gym_member, user: user1, gym: gym3)
gym_member8 = create(:gym_member, user: user5, gym: gym3)
gym_member9 = create(:gym_member, user: user7, gym: gym3)
gym_member10 = create(:gym_member, user: user10, gym: gym3)

gym_member11 = create(:gym_member, user: user2, gym: gym4)
gym_member12 = create(:gym_member, user: user3, gym: gym4)
gym_member13 = create(:gym_member, user: user4, gym: gym4)
gym_member14 = create(:gym_member, user: user7, gym: gym4)
gym_member16 = create(:gym_member, user: user8, gym: gym4)
gym_member17 = create(:gym_member, user: user9, gym: gym4)

gym_member18 = create(:gym_member, user: user1, gym: gym5)
gym_member19 = create(:gym_member, user: user2, gym: gym5)
gym_member20 = create(:gym_member, user: user5, gym: gym5)

# EVENTS (user id is the 'host')
event1 = create(:event, user: user1)
event2 = create(:event, user: user1)
event3 = create(:event, user: user1)
event4 = create(:event, user: user3)
event5 = create(:event, user: user3)
event6 = create(:event, user: user4)
event7 = create(:event, user: user4)
event8 = create(:event, user: user4)
event9 = create(:event, user: user4)
event10 = create(:event, user: user6)
event11 = create(:event, user: user7)
event12 = create(:event, user: user7)
event13 = create(:event, user: user9)
event14 = create(:event, user: user10)
event15 = create(:event, user: user10)

# INVITATIONS

# FRIENDSHIPS
friendship1 = create(:friendship, follower_id: user1, followee_id: user3)
friendship2 = create(:friendship, follower_id: user1, followee_id: user9)
friendship3 = create(:friendship, follower_id: user1, followee_id: user10)
friendship4 = create(:friendship, follower_id: user3, followee_id: user1)
friendship5 = create(:friendship, follower_id: user4, followee_id: user7)
friendship6 = create(:friendship, follower_id: user4, followee_id: user8)
friendship7 = create(:friendship, follower_id: user5, followee_id: user6)
friendship8 = create(:friendship, follower_id: user6, followee_id: user2)
friendship9 = create(:friendship, follower_id: user6, followee_id: user10)
friendship10 = create(:friendship, follower_id: user7, followee_id: user1)
friendship11 = create(:friendship, follower_id: user7, followee_id: user6)
friendship12 = create(:friendship, follower_id: user7, followee_id: user9)
friendship13 = create(:friendship, follower_id: user7, followee_id: user10)
friendship14 = create(:friendship, follower_id: user8, followee_id: user2)
friendship15 = create(:friendship, follower_id: user8, followee_id: user3)
friendship16 = create(:friendship, follower_id: user9, followee_id: user5)
friendship17 = create(:friendship, follower_id: user9, followee_id: user6)
friendship18 = create(:friendship, follower_id: user9, followee_id: user8)
friendship19 = create(:friendship, follower_id: user9, followee_id: user10)
friendship20 = create(:friendship, follower_id: user10, followee_id: user3)
