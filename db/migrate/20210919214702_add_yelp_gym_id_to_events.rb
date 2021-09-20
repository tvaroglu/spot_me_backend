class AddYelpGymIdToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :yelp_gym_id, :string
  end
end
