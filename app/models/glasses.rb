class Glasses < ActiveRecord::Base
  attr_accessible :name, :description, :price, :image, :manufacturer_id

  belongs_to :manufacturer

  validates_presence_of :name
  validates_numericality_of :price
end
