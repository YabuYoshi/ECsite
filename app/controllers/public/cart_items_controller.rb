class Public::CartItemsController < ApplicationController
  def create
    #binding.pry
    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      if customer_signed_in?
        if @cart_item
           @cart_item.amount += CartItem.new(cart_item_params).amount
        else
           @cart_item = CartItem.new(cart_item_params)
           @cart_item.customer_id = current_customer.id
        end

        if @cart_item.save!
          flash[:notice] = 'ModelClassName was successfully created.'
          redirect_to "/cart_items"
        else
          redirect_to items_path
        end
      else
        redirect_to "/"
      end
  end


  def index
    @cart_items = current_customer.cart_items
  end

  def update
    @cart_item = CartItem.find(params[:id])
      if @cart_item.update(cart_item_params)
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

  def destroy_all
    @cart_item = CartItem.all
    @cart_item.destroy_all
    redirect_to "/cart_items"
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
