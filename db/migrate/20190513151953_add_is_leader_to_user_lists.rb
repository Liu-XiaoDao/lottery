class AddIsLeaderToUserLists < ActiveRecord::Migration[5.1]
  def change
    add_column :user_lists, :is_leader, :boolean
    add_column :user_lists, :leader_id, :integer
  end
end
