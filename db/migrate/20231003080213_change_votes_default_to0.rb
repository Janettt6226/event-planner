class ChangeVotesDefaultTo0 < ActiveRecord::Migration[7.0]
  def change
    change_column :slots, :votes, :integer, default: 0
  end
end
