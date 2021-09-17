class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.references :gym, foreign_key: true
      t.datetime :date_time
      t.string :activity

      t.timestamps
    end
  end
end
