class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:index,:show]
  def index
    @all_items = Item.all
    @items = Item.all.page(params[:page]).per(8)
    
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end