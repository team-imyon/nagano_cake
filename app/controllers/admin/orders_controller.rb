class Admin::OrdersController < ApplicationController
  
  def index
    @orders = Order.all.page(params[:page]).per(10)
    
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end
end
