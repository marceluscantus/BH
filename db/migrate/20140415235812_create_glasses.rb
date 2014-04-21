class CreateGlasses < ActiveRecord::Migration
  def change
    create_table :glasses do |t|
    	t.column :glasses_name, :string, :limit => 255, :null => false
     	t.column :description, :string, :limit=> 255
     	t.column :price, :float
     	t.column :manufacturer_id, :integer, :null => false
        t.timestamps
    end
     say_with_time 'Adding foreing keys' do
      # Add foreign key reference to publishers table
      execute 'ALTER TABLE glasses ADD CONSTRAINT fk_glasses_manufacturers
              FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(id) ON DELETE CASCADE'
    end
  end
end
