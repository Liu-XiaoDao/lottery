class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories do |t|
      t.string 'abid'
      # t.string 'product_type'
      # t.string 'product_name'
      t.integer 'size'
      t.string 'unit'
      # t.string 'list_price'
      # t.string 'vial_type'
      # t.string 'is_unpublished'
      # t.string 'bulk_stock'
      # t.integer 'stock'
      # t.string 'lot_no'
      t.integer 'fridge'
      # t.integer 'shelf'
      # t.integer 'tray'
      # t.string 'box', limit: 10
      # t.string 'start_pos', limit: 10
      # t.string 'is_quarantined'
      # t.string 'barcode'
      # t.string 'when_created'
      # t.string 'created_by', limit: 30
      # t.date 'expiry'
      # t.string 'location_id'
      # t.string 'hazards'
      # t.string 'original_stock_id'
      # t.string 'supplier_lot_no'

      t.timestamps
    end
  end
end
