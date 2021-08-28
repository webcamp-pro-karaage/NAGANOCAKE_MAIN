class OrderedItem < ApplicationRecord

  enum product_status: { 着手不可: 0, 製作待ち: 1, 製作中: 2, 製作完了: 3 }

  belongs_to :item
  belongs_to :order

  def subtotal
    quantity * purchase_price
  end

end
