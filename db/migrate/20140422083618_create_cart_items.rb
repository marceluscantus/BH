class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.column :glasses_id, :integer
      t.column :cart_id, :integer
      t.column :price, :float
      t.column :amount, :integer
      t.column :created_at, :datetime
    end
  end
end
