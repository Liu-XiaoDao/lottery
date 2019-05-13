class CreateFamilies < ActiveRecord::Migration[5.1]
  def change
    create_table :families do |t|
      t.string 'name'
      t.string 'type'
      t.integer 'user_list_id'
      t.timestamps
    end
  end
end
