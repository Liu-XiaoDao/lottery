class AddNotesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :notes, :string
  end
end
