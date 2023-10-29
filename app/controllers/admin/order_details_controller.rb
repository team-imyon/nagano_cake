class Admin::OrderDetailsController < ApplicationController
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all
  
    if @order_detail.update(order_detail_params)
      @order.update(status: "production") if @order_detail.making_status == "production"
      is_updated = @order_details.all? { |order_detail| order_detail.making_status == "completed" }
      @order.update(status: "preparing") if is_updated
      
    end
    redirect_to admin_order_path(@order)
  end

private
 def order_detail_params
  params.require(:order_detail).permit(:making_status)
 end 
 
  def order_params
    params.permit(:status)
  end
  
end
