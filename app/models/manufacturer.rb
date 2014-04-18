class Manufacturer < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :glasses
  attr_accessible :company_name, :city, :telephone, :mail, :address
  validates_presence_of :company_name

  def name
      "#{company_name}"
  end
end
