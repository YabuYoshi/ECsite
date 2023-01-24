class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
      if @order.save
        current_customer.cart_items.each do |cart_item|
          @order_detail = OrderDetail.new
          @order_detail.item_id = cart_item.item_id
          @order_detail.order_id = cart_item.customer_id
          @order_detail.amount = cart_item.amount
          @order_detail.price = cart_item.item.price
          @order_detail.save
        end
        current_customer.cart_items.destroy_all
        flash[:notice] = 'ModelClassName was successfully created.'
        redirect_to :complete
      else
        render :new
      end
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @cart_items = current_customer.cart_items
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
    params.require(:order).permit(:shipping_cost, :postal_code, :address, :name, :total_payment, :payment_method)
  end

end

