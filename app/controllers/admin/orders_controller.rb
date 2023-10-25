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

end
