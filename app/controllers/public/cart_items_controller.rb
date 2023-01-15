class Public::CartItemsController < ApplicationController
  def create
    #binding.pry
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
      if @cart_item.save!
        flash[:notice] = 'ModelClassName was successfully created.'
        redirect_to "/cart_items"
      else
        redirect_to items_path
      end
  end

  def index
    @cart_items = current_customer.cart_items
  end

  def update
    @cart_item = CartItem.find(params[:id])
      if @cart_item.update(params[:cart_item])
        flash[:notice] = 'ModelClassName was successfully updated.'
        redirect_to "/cart_items"
      else
        render :index
      end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to "/cart_items"
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
