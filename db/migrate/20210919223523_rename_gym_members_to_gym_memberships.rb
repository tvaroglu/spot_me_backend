class RenameGymMembersToGymMemberships < ActiveRecord::Migration[5.2]
  def change
    rename_table :gym_members, :gym_memberships
  end
end
