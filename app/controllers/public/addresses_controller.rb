class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
      if @address.save
        flash[:notice] = 'Address was successfully created.'
        redirect_to "/addresses"
      else
        @addresses = Address.all
        render :index
      end
  end

  def update
    @address = Address.find(params[:id])
      if @address.update(address_params)
        flash[:notice] = 'Address was successfully updated.'
        redirect_to "/addresses"
      else
        render :edit
      end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to "/addresses"
  end

  private

  def address_params
   params.require(:address).permit(:name, :postal_code, :address)
  end

  def is_matching_login_user
    customer_id = params[:id].to_i
    unless customer_id == current_customer.id
      redirect_to root_path
    end
  end

end
