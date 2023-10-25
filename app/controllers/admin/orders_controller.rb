class Admin::OrdersController < ApplicationController

  def index
    @customer = Customer.find(params[:id])
    @orders = Order.where(customer_id: @customer.id).order(created_at: :desc).page(params[:page]).per(10)
  end


  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    @total = 0
  end
  
  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_params)
      @order_details.update_all(making_status: "製造待ち") if @order.status == "入金確認"
    end
      redirect_to admin_order_path(@order)
  end

end
