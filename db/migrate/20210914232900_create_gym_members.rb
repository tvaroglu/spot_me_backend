class CreateGymMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :gym_members do |t|
      t.references :user, foreign_key: true
      t.references :gym, foreign_key: true

      t.timestamps
    end
  end
end
