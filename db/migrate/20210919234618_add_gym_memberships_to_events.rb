class AddGymMembershipsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :gym_membership, foreign_key: true
  end
end
