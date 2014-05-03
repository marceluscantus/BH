# encoding: UTF-8
class OrderItem < ActiveRecord::Base
  attr_accessible :glasses_id, :order_id, :price, :amount

  belongs_to :order
  belongs_to :glasses

  def validate
    errors.add(:amount, "debe ser más de uno") unless amount.nil? || amount > 0
    errors.add(:price, "debe ser un número positivo") unless price.nil? || price > 0.0
  end
end
