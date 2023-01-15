class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
      if @address.save
        flash[:notice] = 'Address was successfully created.'
        redirect_to "/address"
      else
        @addresses = Address.all
        render :index
      end
  end

  def update
    @address = Address.find(params[:id])
      if @address.update(address_params)
        flash[:notice] = 'Address was successfully updated.'
        wants.html { redirect_to(@address) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @address.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy

    respond_to do |wants|
      wants.html { redirect_to(addresss_url) }
      wants.xml  { head :ok }
    end
  end

  private

  def address_params
   params.require(:address).permit(:name, :postal_code, :address)
  end

end
