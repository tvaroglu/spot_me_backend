class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :google_id
      t.string :google_token
      t.string :google_image_url
      t.string :zip_code
      t.string :summary
      t.integer :goal
      t.boolean :availability_morning, default: false, null: false
      t.boolean :availability_afternoon, default: false, null: false
      t.boolean :availability_evening, default: false, null: false

      t.timestamps
    end
  end
end
