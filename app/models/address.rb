class Address < ApplicationRecord
  validates :post_code, presence:true
  validates :address, presence:true
  validates :name, presence:true
 
  belongs_to :customer
  
  def order_address
    self.post_code + "　" + self.address+ "　" + self.name
  end
  
  
end
