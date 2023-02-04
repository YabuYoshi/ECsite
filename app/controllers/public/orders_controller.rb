class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @cart_items = current_customer.cart_items
    if @cart_items.empty?
      redirect_to cart_items_path
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
      if @order.save
        current_customer.cart_items.each do |cart_item|
          @order_detail = OrderDetail.new
          @order_detail.item_id = cart_item.item_id
          @order_detail.order_id = @order.id
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
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @cart_items = current_customer.cart_items
    @order.shipping_cost = 800
    @orders = current_customer.orders
  end

  def confirm
    if params[:order][:address_option] == "1"
      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
      @cart_items = current_customer.cart_items
      @order.shipping_cost = 800

    elsif params[:order][:address_option] == "2"
      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
      @cart_items = current_customer.cart_items
      @order.shipping_cost = 800

    elsif params[:order][:address_option] == "3"
      @order = Order.new(order_params)
      @cart_items = current_customer.cart_items
      @order.shipping_cost = 800

    end
  end


  def complete
  end

  private

  def order_params
    params.require(:order).permit(:shipping_cost, :postal_code, :address, :name, :total_payment, :payment_method)
  end

end

