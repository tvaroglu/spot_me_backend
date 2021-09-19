class RemoveGymIdFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :gym_id, :bigint
  end
end
