class RemoveGymIdFromGymMembers < ActiveRecord::Migration[5.2]
  def change
    remove_column :gym_members, :gym_id, :bigint
  end
end
