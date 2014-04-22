class CartItem < ActiveRecord::Base
  attr_accessible :glasses_id, :cart_id, :price, :amount
  belongs_to :cart
  belongs_to :glasses
end
