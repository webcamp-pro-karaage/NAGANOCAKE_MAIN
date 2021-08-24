class Public::CustomersController < ApplicationController
  before_action :set_customer

    def show
    end
    
    def edit
    end
    
    def update
      @customer = current_customer
        if @customer.update(customer_params)
          flash[:notice]="You have updated successfully."
          redirect_to customer_path
        else
          render :edit
        end
    end
    
    def withdraw
    end
    
    def unsubscribe
      @customer = current_customer
        @customer.update(is_deleted: true)
        reset_session
        flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
        redirect_to root_path
    end
    
    private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :post_code, :address, :phone_number)
    end

    def set_customer
      @customer = current_customer
    end

end