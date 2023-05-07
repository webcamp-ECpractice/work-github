class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name_address
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
