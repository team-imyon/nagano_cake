class Admin::ItemsController < ApplicationController
# rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  
  def index
    @items = Item.all.page(params[:page]).per(10)

  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      @item = Item.new
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end
    
  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to admin_item_path(item.id)
    else
      @item = Item.find(params[:id])
      render :edit
    end
  end

  def show
    @item = Item.find(params[:id])
    @genre = @item.genre
    # @order_detailを取得
    @order_detail = OrderDetail.find_by(item_id: @item.id)
  end

  private
  # ストロングパラメータ
  def item_params
    params.require(:item).permit(:image, :name, :explanation, :genre_id, :price, :is_active)
  end
  
  # def record_not_found
    # flash[:alert] = "アイテムが見つかりません"
    # redirect_to item_path # リダイレクト先を指定してください
  # end

end
