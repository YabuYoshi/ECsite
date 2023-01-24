class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.all
  end

  def update
    @order = Order.find(params[:id])
      if @order.update(order_params)
        flash[:notice] = 'ModelClassName was successfully updated.'
        redirect_to
      else
        render :action
      end
  end

  protected
  def order_params
    params.require(:order).permit(:shipping_cost, :postal_code, :address, :name, :total_payment, :order_status, :payment_method)
  end
end

