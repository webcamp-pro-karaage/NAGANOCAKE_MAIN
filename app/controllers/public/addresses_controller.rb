class Public::AddressesController < ApplicationController

   before_action :authenticate_customer!


    def index
      @customer = current_customer
      @addresses = @customer.addresses
      @address = Address.new
    end

    def create
      @address = Address.new(address_params)
      @address.customer_id = current_customer.id
      @address.save
      redirect_to addresses_path
      
      # customer部分が実装できたら↓↓
      # if @address.save
      #   flash[:notice] = "登録しました"
      #   redirect_to addresses_path
      # else
      #   @customer = current_customer
      #   @address = @customer.addresses.all
      #   render :index
      # end
    end

    def edit
      @address = Address.find(params[:id])
    end

    def update
      @address = Address.find(params[:id])
      if @address.update(address_params)
        flash[:notice] = "更新しました"
        redirect_to addresses_path(@address.id)
      else
        render 'edit'
      end
    end

    def destroy
      address = Address.find(params[:id])
      address.destroy
      redirect_to addresses_path
    end


    private
     def address_params
        params.require(:address).permit(:name, :post_code, :address)
     end


end
