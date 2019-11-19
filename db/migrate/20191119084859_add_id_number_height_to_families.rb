class AddIdNumberHeightToFamilies < ActiveRecord::Migration[5.1]
  def change
    add_column :families, :id_number, :string
    add_column :families, :height, :string
  end
end
