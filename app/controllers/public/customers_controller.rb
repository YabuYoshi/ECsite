class Public::CustomersController < ApplicationController

 def show
  @customer = current_customer
 end

 def edit
   @customer = current_customer
 end

 def update
   @customer = current_customer
     if @customer.update(customer_params)
       flash[:notice] = 'Customer was successfully updated.'
       redirect_to customers_path
     else
       render :edit
     end
 end

 def unsubscribe
 end

 def withdrawal
  current_customer.update(is_deleted: true)
  reset_session
  redirect_to root_path
 end

 private

 def customer_params
   params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :email, :telephone_number)
 end

end

