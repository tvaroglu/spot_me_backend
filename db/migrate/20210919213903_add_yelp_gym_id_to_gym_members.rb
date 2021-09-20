class AddYelpGymIdToGymMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :gym_members, :yelp_gym_id, :string
  end
end
