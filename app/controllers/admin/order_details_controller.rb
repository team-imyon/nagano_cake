class Admin::OrderDetailsController < ApplicationController
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all
    @order_detail.update(order_detail_params)
    
    if @order_detail.making_status == "completed"
      @order_detail.update(order_detail_params)
        @order_details.each do |order_detail|
        if order_detail.making_status = "production"
          redirect_to admin_order_path(@order)
        else
          @order.status = 3
          @order.update(order_params)
        end
      end
    end
    redirect_to admin_order_path(@order)
  end

    # is_updated = true
    #   if @order_detail.update(order_detail_params)
    #     @order.update(status: "production") if @order_detail.making_status == "production"
    #     @order_details.each do |order_detail|
    #       if order_detail.making_status != "completed"
    #         is_updated = false
    #       end
    #     end
    #     @order.update(status: "preparing") if is_updated
    #   end
    # redirect_to admin_order_path(@order)
  # end
    # @order.update(order_params)
    # if @order.status == "confirmation"
    #   @order_details.each do |order_detail|
    #     order_detail.making_status = 1
    #     order_detail.update(order_detail_params)
    #   end
    # end
    #   redirect_to admin_order_path(@order)
    

  
private
 def order_detail_params
  params.require(:order_detail).permit(:making_status)
 end 
 
  def order_params
    params.permit(:status)
  end

  
end
