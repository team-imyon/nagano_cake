class Admin::OrdersController < ApplicationController

  def index
  end


  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    @total = 0
  end

end
