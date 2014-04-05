class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.column :company_name, :string
      t.column :city, :string
      t.column :telephone, :string
      t.column :mail, :string
      t.column :address, :string
      t.timestamps
    end
  end
end