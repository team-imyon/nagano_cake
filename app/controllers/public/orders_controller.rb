class Public::OrdersController < ApplicationController
  #ryon
  before_action :authenticate_customer!, only: [:new, :confirm, :create, :index, :show, :complete]
  
  def new
  end

  def confirm
    # ryon
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @postage = 800  #送料800円で固定
    # フォームから送信された注文の支払い方法を受け取り
    @payment_method = params[:order][:payment_method]
    # 以下、商品合計額の計算
    # 空の配列作成
    # 各カートアイテムの価格と数量の金額を格納するのに使用
    ary = []
    # 商品の価格×数量＝金額(ary配列に追加)
    @cart_items.each do |cart_item|
      ary << cart_item.item.price*cart_item.quantity
    end
     # ary.sumですべてのカートアイテムの金額を計算し、＠cart_items_priceに設定
    @cart_items_price = ary.sum
    # 支払い合計金額＝送料＋カート内商品の合計金額
    @total_payment = @postage + @cart_items_price
    # フォームから送信された注文の配送先情報を受け取る
    @address_type = params[:order][:address_type]
    # ↑に基づいて異なる配送先情報を設定
    case @address_type
    when "customer_address" #カスタマーの登録住所を使用
      @selected_address = current_customer.post_code + " " + current_customer.address + " " + current_customer.last_name + current_customer.first_name
    when "registered_address" #登録済みの住所を使用
      unless params[:order][:registered_address_id] ==""
        #各条件内にて selected~ 選択された情報を格納
        selected = Address.find(params[:order][:registered_address_id])
        @selected_address = selected.post_code + " " + selected.address + " " + selected.name
      else
        render :new #エラー時には新しいページへ
      end
    when "new_address" #新しい住所を使用
      unless params[:order][:new_post_code] == "" && params[:order][:new_address] == "" && params[:order][:new_name] == ""
        @selested_address = params[:order][:new_post_code] + " " + params[:order][:new_address] + " " + params[:prder][:new_name]
      else
        render :new #エラー時には新しいページへ
      end
    end
  end

  def create
    @order = Order.new
    #現在ログインしているユーザーのID
    @order.customer_id = current_customer.id
    @order.postage = 800 #固定送料
    #カート内の全ての商品を取得
    @cart_items = CartItem.where(customer_id: current_customer.id)
    # 空の配列作成
    # 各カートアイテムの価格と数量の金額を格納するのに使用
    ary = []
    # 商品の価格×数量＝金額(ary配列に追加)
    @cart_items.each do |cart_item|
      ary << cart_item.item.price*cart_item.quantity
    end
    # ary.sumですべてのカートアイテムの金額を計算し、＠cart_items_priceに設定
    @cart_items_price = ary.sum
    #送料とカートアイテムの合計金額
    @order.totle_price = @order.postage + @cart_items_price
    # ユーザーが選択した支払い方法を設定
    @order.payment_method = params[:order][:payment_method]
    if @order.payment_method == "credit_card"
      @order.status = 1 #クレジットカード
    else
      @order.status = 0 #その他
    end
    
    address_type = params[:order][:address_type]
    #address_typeに応じて異なる配送先情報を@oederに設定
    case address_type
  when "customer_address" 
    @order.post_code = current_customer.post_code
    @order.address = current_customer.address
    @order.name = current_cutomer.last_name + current_customer.first_name
  when "registered_address"
    Address.find(params[:order][:registered_address_id])
    selected = Address.find(params[:order][:registered_address_id])
    @order.post_code = selected.post_code
    @order.address = selected.address
    @order.name = selected.name
  when "new_address"
    @order.post_code = params[:order][:new_post_code]
    @order.address = params[:order][:new_address]
    @order.name = params[:order][:new_name]
  end
  
  if @order.save
    if @order.status == 0
      @cart_items.each do |cart_item|
        OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 0)
      end
    else
      @cart_items.each do |cart_item|
        OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 1)
      end
    end
    @cart_items.destroy_all
    redirect_to complete_orders_path
  else
    render :items
  end
  end
  end
  
  def complete
  end

  def index
    #ryon
    #where〜 ログイン中の会員の注文のみを取得
    #order(created_at: :desc) で最新の注文が最初に表示される
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
    # 顧客の注文履歴
    @index = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end
end
