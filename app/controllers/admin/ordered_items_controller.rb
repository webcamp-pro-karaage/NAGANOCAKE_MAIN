class Admin::OrderedItemsController < ApplicationController
  skip_before_action :authenticate_customer!
  def update
    @order = Order.find(params[:id])
    @ordered_item = OrderedItem.find(params[:id])
    if @ordered_item.update(ordered_item_params)
      redirect_to admin_order_path(@ordered_item.order.id)
    end
  end


  private

  def ordered_item_params
   params.require(:ordered_item).permit(:product_status)
  end
end
