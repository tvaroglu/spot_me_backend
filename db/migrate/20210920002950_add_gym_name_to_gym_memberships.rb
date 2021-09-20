class AddGymNameToGymMemberships < ActiveRecord::Migration[5.2]
  def change
    add_column :gym_memberships, :gym_name, :string
  end
end
