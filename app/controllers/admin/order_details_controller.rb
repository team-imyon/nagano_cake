class Admin::OrderDetailsController < ApplicationController
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all
    @order_detail.update(order_detail_params)
    
    is_updated = true
      if @order_detail.update(order_detail_params)
        @order.update(status: "製造中") if @order_detail.making_status == "製造中"
        @order_details.each do |order_detail|
          if order_detail.making_status != "製造完了"
            is_updated = false
          end
        end
        @order.update(status: "発送準備中") if is_updated
      end
        redirect_to admin_order_path(@order)
  end
end
