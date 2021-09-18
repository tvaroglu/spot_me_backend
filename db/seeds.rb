# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = create(:user, availability_morning: true)
user2 = create(:user, availability_morning: true) # no followers :(
user3 = create(:user, availability_morning: true, availability_afternoon: true)
user4 = create(:user, availability_morning: true, availability_afternoon: true) # no followees :(
user5 = create(:user, availability_morning: true, availability_afternoon: true)
user6 = create(:user, availability_morning: true, availability_evening: true)
user7 = create(:user, availability_evening: true)
user8 = create(:user, availability_morning: true, availability_morning: true, availability_evening: true)
user9 = create(:user, availability_afternoon: true, availability_evening: true)
user10 = create(:user, availability_evening: true)

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
