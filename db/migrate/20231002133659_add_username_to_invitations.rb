class AddUsernameToInvitations < ActiveRecord::Migration[7.0]
  def change
    add_column :invitations, :username, :string
  end
end
