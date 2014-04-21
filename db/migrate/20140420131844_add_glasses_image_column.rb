class AddGlassesImageColumn < ActiveRecord::Migration
  def self.up
    add_attachment :glasses, :image
  end

  def self.down
    remove_attachment :glasses, :image
  end
end
