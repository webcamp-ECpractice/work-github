class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name_address
  end

  def add_tax_price
    (self.order_detail.unit_price * 1.1).round
  end

  def subtotal
    add_tax_price * order_detail.items_amount
  end

 def self.total_price(order)
    array = []
    orders.each do |order|
      array << order.order_details.unit_price * order.order_details.items_amount
    end

    return (array.sum * 1.1).floor
  end

  enum payment_method: {
    credit:1, #クレジットカード
    bank:2 #銀行振込
  }

  enum is_ordered: {
    no_payment:1, #入金待ち
    ok_payment:2, #入金確認
    making:3, #動作中
    preparing_delivery:4,#発送準備中
    delivered:5 #発送済み
  }


end
