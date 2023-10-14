class AddColumnsToSuggestions < ActiveRecord::Migration[7.0]
  def change
    add_column :suggestions, :available?, :boolean, default: false
  end
end
