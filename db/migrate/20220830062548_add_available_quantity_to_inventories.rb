class AddAvailableQuantityToInventories < ActiveRecord::Migration[5.1]
  def change
    add_column :inventories, :available_quantity, :integer
  end
end
