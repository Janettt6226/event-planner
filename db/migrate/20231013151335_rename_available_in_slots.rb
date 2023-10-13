class RenameAvailableInSlots < ActiveRecord::Migration[7.0]
  def change
    rename_column :slots, :available?, :available
  end
end
