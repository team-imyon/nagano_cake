class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @item = Item.all
    # @cart_item = @items.all
    @total = 0
  end
  
  def update
  end
  
  def create
  end
  
  def destroy
  end
  
  def all_destroy
  end
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
  
end
