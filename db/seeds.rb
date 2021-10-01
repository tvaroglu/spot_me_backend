# require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

# USERS
user1 = User.all.order(:id)[0]
user2 = User.all.order(:id)[1]
user3 = User.all.order(:id)[2]
user4 = User.all.order(:id)[3]
user5 = User.all.order(:id)[4]
user6 = User.all.order(:id)[5]
user7 = User.all.order(:id)[6]
user8 = User.all.order(:id)[7]
user9 = User.all.order(:id)[8]
user10 = User.all.order(:id)[9]
user11 = User.all.order(:id)[10]

# GYM MEMBERSHIPS
gym_member1 = GymMembership.all.order(:id)[0]
gym_member2 = GymMembership.all.order(:id)[1]
gym_member3 = GymMembership.all.order(:id)[2]
gym_member4 = GymMembership.all.order(:id)[3]
gym_member5 = GymMembership.all.order(:id)[4]
gym_member6 = GymMembership.all.order(:id)[5]
gym_member7 = GymMembership.all.order(:id)[6]
gym_member8 = GymMembership.all.order(:id)[7]
gym_member9 = GymMembership.all.order(:id)[8]
gym_member10 = GymMembership.all.order(:id)[9]
gym_member11 = GymMembership.all.order(:id)[10]
gym_member12 = GymMembership.all.order(:id)[11]
gym_member13 = GymMembership.all.order(:id)[12]
gym_member14 = GymMembership.all.order(:id)[13]
#gym_member15 :(
gym_member16 = GymMembership.all.order(:id)[14]
gym_member17 = GymMembership.all.order(:id)[15]
gym_member18 = GymMembership.all.order(:id)[16]
gym_member19 = GymMembership.all.order(:id)[17]
gym_member20 = GymMembership.all.order(:id)[18]

# EVENTS (user is the 'invitee')
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
