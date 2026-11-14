class AddUniqueIndexToGymMemberships < ActiveRecord::Migration[6.0]
  def change
    add_index :gym_memberships, [:user_id, :yelp_gym_id], unique: true,
              name: 'index_gym_memberships_on_user_id_and_yelp_gym_id'
  end
end
