class Admin::OrderedItemsController < ApplicationController
  skip_before_action :authenticate_customer!
  def update
    @ordered_item = OrderedItem.find(params[:id])
    @ordered_item.update(ordered_item_params)
    order = @ordered_item.order
    @ordered_items = order.ordered_items
    ordered_items_completed = @ordered_items.where(product_status: "製作完了" )
    if @ordered_item.product_status == "製作中"
      @ordered_item.order.order_status = "製作中"
      @ordered_item.order.save
    elsif @ordered_items.count == ordered_items_completed.count
      @ordered_item.order.order_status = "発送準備中"
      @ordered_item.order.save
    end
    redirect_to admin_order_path(@ordered_item.order.id)

  end


  private

  def ordered_item_params
   params.require(:ordered_item).permit(:product_status)
  end
end
