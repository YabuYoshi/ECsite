class Public::CustomersController < ApplicationController

 def show
  @customer = Customer.find(params[:id])
  respond_to do |wants|
    wants.html # show.html.erb
    wants.xml  { render :xml => @customer }
  end
 end

 def edit
   @customer = Customer.find(params[:id])
 end

 def update
   @customer = Customer.find(params[:id])

     if @customer.update(customer_params)
       flash[:notice] = 'Customer was successfully updated.'
       redirect_to customer_path(@customer.id)
     else
       render :edit
     end
 end

 def unsubscribe
 end

 def withdrawal
 end

 private

 def customer_params
   params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number)
 end

end


