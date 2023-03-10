class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
      if @order_detail.update(order_detail_params)
        flash[:notice] = 'ModelClassName was successfully updated.'
        redirect_to :show
      else
        render :top
      end
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:item_id, :amount, :price)
  end

end
