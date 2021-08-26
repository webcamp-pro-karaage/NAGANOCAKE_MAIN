class CartItem < ApplicationRecord

  validates :quantity, presence: true

  belongs_to :customer
  belongs_to :item

  def subtotal
    item.add_tax_price_without_tax * quantity
  end

end
