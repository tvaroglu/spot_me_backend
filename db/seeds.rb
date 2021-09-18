# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = create(:user, availability_morning: true)
user2 = create(:user, availability_morning: true)
user3 = create(:user, availability_morning: true, availability_afternoon: true)
user4 = create(:user, availability_morning: true, availability_afternoon: true)
user5 = create(:user, availability_morning: true, availability_afternoon: true)
user6 = create(:user, availability_morning: true, availability_evening: true)
user7 = create(:user, availability_evening: true)
user8 = create(:user, availability_morning: true, availability_morning: true, availability_evening: true)
user9 = create(:user, availability_afternoon: true, availability_evening: true)
user10 = create(:user, availability_evening: true)
