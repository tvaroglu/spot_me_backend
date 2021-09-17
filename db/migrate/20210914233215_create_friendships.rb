class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.bigint :follower_id
      t.bigint :followee_id

      t.timestamps
    end
  end
end
