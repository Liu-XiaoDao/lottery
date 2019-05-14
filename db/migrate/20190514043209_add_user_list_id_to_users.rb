class AddUserListIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_list_id, :integer
  end
end
