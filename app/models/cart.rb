class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :cart_items
  has_many :glasses, :through => :cart_items
  def add(glasses_id)
    items = cart_items.find_all_by_glasses_id glasses_id
    glasses = Glasses.find glasses_id
    if items.size < 1
      ci = cart_items.create :glasses_id => glasses_id, :amount => 1, :price => glasses.price
    else
      ci = items.first
      ci.update_attribute :amount, ci.amount + 1
    end
    ci
  end

  def remove(glasses_id)
    ci = cart_items.find_by_glasses_id glasses_id 
    if ci.amount > 1
      ci.update_attribute :amount, ci.amount - 1
    else
      CartItem.destroy ci.id
    end
    ci
  end

  def total
    sum = 0
    cart_items.each do |item| sum += item.price * item.amount end
    sum
  end
end

