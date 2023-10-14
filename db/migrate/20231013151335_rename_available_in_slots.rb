class RenameAvailableInSuggestions < ActiveRecord::Migration[7.0]
  def change
    rename_column :suggestions, :available?, :available
  end
end
