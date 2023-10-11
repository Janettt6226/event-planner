class ChangeColumnNameInInvitation < ActiveRecord::Migration[7.0]
  def change
    rename_column :invitations, :participate?, :participate
  end
end
