class Item < ApplicationRecord
  attachment :image
  belongs_to :genre
  validates :genre_id, presence: true
  validates :item_name, presence: true
  validates :description, presence: true
  validates :price_without_tax, presence: true


def  add_tax_price_without_tax
  (self.price_without_tax * 1.10).round
end
  
  
end
