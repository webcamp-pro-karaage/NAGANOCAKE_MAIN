class Admin::OrdersController < ApplicationController
  skip_before_action :authenticate_customer!
  def show
    @order = Order.find(params[:id])
    @postage = 800
    @ordered_items = @order.ordered_items
    @total_price = 0
    @ordered_items.each do |ordered_item|
      @total_price += ordered_item.subtotal
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @ordered_items = @order.ordered_items
    if @order.order_status == "入金確認"
      @ordered_items.each do |ordered_item|
        ordered_item.product_status = "製作待ち"
        ordered_item.save
      end
    end
    redirect_to admin_order_path(@order.id)
  end


  private

  def order_params
    params.require(:order).permit(:order_status)
  end
end
