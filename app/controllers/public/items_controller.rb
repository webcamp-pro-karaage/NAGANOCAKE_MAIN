class Public::ItemsController < ApplicationController
  skip_before_action :authenticate_customer!, only: [:show, :index]


  def index
    @items = Item.page(params[:page]).reverse_order.per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end


end
