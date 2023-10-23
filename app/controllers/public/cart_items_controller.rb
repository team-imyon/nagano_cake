class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
  end

  def update
    # 終わったらまたカートアイテムの画面いく！
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path

  end

  def create
    # カート内に商品データ追加
    # データを入れるための箱作成
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.save
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def all_destroy
    # 現在の顧客のカート内のすべての商品を取得
    cart_items = current_customer.cart_items
    # カート内のすべての商品を削除
    cart_items.destroy_all
    # カート内の商品を削除した後、カート内の中身を表示する画面にリダイレクト
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end

end
