class CreateUserLists < ActiveRecord::Migration[5.1]
  def change
    create_table :user_lists do |t|
      t.string   'name', :limit => 20
      t.timestamps
    end
  end
end
