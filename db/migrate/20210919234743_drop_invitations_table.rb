class DropInvitationsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :invitations
  end
end
