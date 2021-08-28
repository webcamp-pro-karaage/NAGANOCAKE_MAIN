class Admin::HomesController < ApplicationController
  skip_before_action :authenticate_customer!
  def top
    @orders = Order.page(params[:page]).reverse_order
    @ordered_items = OrderedItem.all
  end
end
