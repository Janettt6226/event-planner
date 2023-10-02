class AddDefaultFalseToInvitation < ActiveRecord::Migration[7.0]
  def change
    change_column :invitations, :participate?, :boolean, default: false
  end
end
