class DropGyms < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :gym_members, :gyms
    remove_foreign_key :events, :gyms
    drop_table :gyms
  end
end
