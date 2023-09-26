class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :item_id, null: false
      t.integer :order_id, null: false
      t.integer :unit_price, null: false
      t.integer :items_amount, null: false
      t.integer :is_maked, null: false, default: 1

      t.timestamps
    end
  end
end
