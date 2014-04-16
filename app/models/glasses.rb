class Glasses < ActiveRecord::Base
  attr_accessible :glasses_name, :description, :price, :image, :manufacturer_id

  belongs_to :manufacturer

  #validates_presence_of :g_name
  #validates_numericality_of :price

  def name
    "#{glasses_name}"
  end
end
