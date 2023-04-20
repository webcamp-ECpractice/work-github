class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.integer :payment_method, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :name_address, null: false
      t.integer :postage, null: false, default: 800
      t.integer :payment_amount, null: false
      t.integer :is_ordered, null: false, default: 1

      t.timestamps
    end
  end
end
