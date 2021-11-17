class CreateFridges < ActiveRecord::Migration[5.1]
  def change
    create_table :fridges do |t|
      t.string 'fridge'
      t.string 'site'
      t.timestamps
    end
  end
end
