class AddNameToGyms < ActiveRecord::Migration[5.2]
  def change
    add_column :gyms, :name, :string
  end
end
