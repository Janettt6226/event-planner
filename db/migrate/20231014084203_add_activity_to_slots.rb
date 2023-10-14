class AddActivityToSuggestions < ActiveRecord::Migration[7.0]
  def change
    add_column :suggestions, :activity, :string
  end
end
