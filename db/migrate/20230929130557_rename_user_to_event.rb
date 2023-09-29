class RenameUserToEvent < ActiveRecord::Migration[7.0]
  def change
    rename_table :user_to_events, :invitations
  end
end
