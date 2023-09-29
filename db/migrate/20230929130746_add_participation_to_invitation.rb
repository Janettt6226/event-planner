class AddParticipationToInvitation < ActiveRecord::Migration[7.0]
  def change
    add_column :invitations, :participate?, :boolean
  end
end
