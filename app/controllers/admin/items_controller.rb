class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    
  end

  def new
    @item = Item.new
  end
  
  def create
    item = @item
    item.save
    redirect_to 'admin/items/:id'
  end

  def edit
  end

  def show
  end
  
  private
  # ストロングパラメータ
  def list_params
    params.require(:item).permit(:image, :name, :explanation, :price)
  end
  
end
