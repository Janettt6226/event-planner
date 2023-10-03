class AddColumnsToSlots < ActiveRecord::Migration[7.0]
  def change
    add_column :slots, :available?, :boolean, default: false
  end
end
