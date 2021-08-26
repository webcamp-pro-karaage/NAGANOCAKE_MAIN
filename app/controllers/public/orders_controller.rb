class Public::OrdersController < ApplicationController
  
  before_action :confirm_params, only: [:confirm]

  

  
  def new
    @order = Order.new
  end
  
  
  def confirm
    @order = Order.new
    @postage = 800
    @cart_items = current_customer.cart_items.all
    @order.payment_method = params[:order][:payment_method]
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += cart_item.subtotal
    end
    @order.total_payment = @total_price + @postage
    case params[:order][:address_option]
      when '0' 
        @order.post_code = current_customer.post_code
        @order.address = current_customer.address
        @order.name = current_customer.full_name
      when '1' 
        address = Address.find(params[:order][:address_id])
        @order.post_code = address.post_code
        @order.address = address.address
        @order.name = address.name
      when '2' 
        @order.post_code = new_post_code
        @order.address = new_address
        @order.name = new_name
    end
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800
    @order.save
    redirect_to order_complete_path
  end
  
  private
  
  def order_params
    params.require(:order).permit(:post_code, :address, :name, :postage, :total_payment, :payment_method, :order_status)
  end
  
  def confirm_params
    params.require(:order).permit(:address_option, :address_id, :new_post_code, :new_address, :new_name, :payment_method)
  end
  
end
