class RemoveAvailableFromSuggestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :suggestions, :available, :string
    remove_column :suggestions, :votes, :string
  end
end
