class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  def self.total_price(cart_items)
    array = []
    cart_items.each do |cart_item|
      array << cart_item.item.price * cart_item.amount
    end

    return (array.sum * 1.1).floor
  end

  def subtotal
    item.add_tax_price * amount
  end

end