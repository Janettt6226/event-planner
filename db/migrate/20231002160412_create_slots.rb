class CreateSuggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :suggestions do |t|
      t.references :event, null: false, foreign_key: true
      t.integer :votes
      t.datetime :date

      t.timestamps
    end
  end
end
