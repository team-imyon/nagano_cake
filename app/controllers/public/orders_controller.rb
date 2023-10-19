class Public::OrdersController < ApplicationController
  def new
  end

  def confirm
  end

  def complete
  end

  def index
    # 顧客の注文履歴
    @index = current_customer.orders
  end

  def show
  end
end
