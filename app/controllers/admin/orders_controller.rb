class Admin::OrdersController < ApplicationController
  skip_before_action :authenticate_customer!
  def show
    @orders = Order.all
    @order = Order.find(params[:id])
    @postage = 800
    @ordered_items = OrderedItem.all
    @total_price = 0
    @ordered_items.each do |ordered_item|
      @total_price += ordered_item.subtotal
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_order_path(@order.id)
    end

    #@ordered_item = OrderedItem.find(params[:id])
    #if @ordered_item.update(ordered_item_params)
      #redirect_to admin_order_path(ordered_item.order.id)
    #end
  end


  private

  def order_params
    params.require(:order).permit(:order_status)
  end
end
