class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
      if @order.save
        flash[:notice] = 'ModelClassName was successfully created.'
        redirect_to "/orders"
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
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:shipping_cost, :postal_code, :address, :name, :total_payment, :order_status, :payment_method)
  end

end

