class AddUserToSlots < ActiveRecord::Migration[7.0]
  def change
    add_reference :slots, :user, foreign_key: true
  end
end
