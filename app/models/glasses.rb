class Glasses < ActiveRecord::Base
  attr_accessible :glasses_name, :description, :price, :image, :manufacturer_id

  belongs_to :manufacturer

  validates_presence_of :glasses_name
  validates_numericality_of :price
  validates_presence_of :manufacturer

  def name
    "#{glasses_name}"
  end
  def self.latest(num)
    find :all, :limit => num, :order => "glasses.id desc", :include => [ :manufacturer ]
  end
end
