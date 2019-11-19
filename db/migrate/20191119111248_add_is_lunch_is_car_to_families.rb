class AddIsLunchIsCarToFamilies < ActiveRecord::Migration[5.1]
    add_column :families, :is_car, :string
    add_column :families, :is_lunch, :string
  def change
  end
end
