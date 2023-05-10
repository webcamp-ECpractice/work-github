class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item


  def subtotal
    unit_price * items_amount
  end

  enum is_maked: {
    no_making: 1, #着手不可
    waiting_for_making: 2, #製作待ち
    making: 3, #製作中
    finish: 4 #製作完了
  }
end
