class RemoveYelpGymIdFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :yelp_gym_id, :string
  end
end
