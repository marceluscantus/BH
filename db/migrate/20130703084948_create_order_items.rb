class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :glasses_id
      t.integer :order_id
      t.float :price
      t.integer :amount
      t.timestamps
    end
  end
end
