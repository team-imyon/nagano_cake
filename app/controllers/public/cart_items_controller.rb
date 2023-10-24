class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    flash[:notice] = "カートの数量を変更しました"
    redirect_to cart_items_path

  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_items = current_customer.cart_items.all
    if cart_item = @cart_items.find_by(item_id: @cart_item.item_id)
    # 同じ商品が既にカートにあるか確認、あれば既存の数量と新しい数量を足す
      if cart_item.amount + @cart_item.amount > 50
        flash[:notice] = "カートの数量は50以下でお願いします"
        redirect_to cart_items_path
      else
        new_amount = cart_item.amount + @cart_item.amount
        cart_item.update_attribute(:amount, new_amount)
        @cart_item.delete
      end
    else
      @cart_item.save
      flash[:notice] = "カートに商品が入りました"
      redirect_to cart_items_path
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:notice] = "カートの商品を削除しました"
    redirect_to cart_items_path
  end

  def destroy_all
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
