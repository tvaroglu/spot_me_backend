class CreateGyms < ActiveRecord::Migration[5.2]
  def change
    create_table :gyms do |t|
      t.string :yelp_gym_id

      t.timestamps
    end
  end
end
