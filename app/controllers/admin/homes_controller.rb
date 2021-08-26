class Admin::HomesController < ApplicationController
  skip_before_action :authenticate_customer!
  def top
    @orders = Order.page(params[:page]).reverse_order
    @ordered_items = OrderedItem.all
    @total_quantity = 0
    @ordered_items.each do |ordered_item|
      @total_quantity += ordered_item.quantity
    end
  end
end
