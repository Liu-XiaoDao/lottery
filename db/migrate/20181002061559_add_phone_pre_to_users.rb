class AddPhonePreToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :pre, :string
    add_column :users, :phone, :string
  end
end
