class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
      if @order.save
        flash[:notice] = 'ModelClassName was successfully created.'
        redirect_to "/orders/confirm"
      else
        render :new
      end
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    @cart_items = current_customer.cart_items
    @order.shipping_cost = 800
    #binding.pry
  end


  def complete
  end

  private

  def order_params
    params.require(:order).permit(:shipping_cost, :postal_code, :address, :name, :total_payment, :order_status, :payment_method)
  end

end

