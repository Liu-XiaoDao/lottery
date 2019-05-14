class AddUserIdToFamilies < ActiveRecord::Migration[5.1]
  def change
    add_column :families, :user_id, :integer
  end
end
