class Public::OrdersController < ApplicationController
  #ryon
  before_action :authenticate_customer!, only: [:new, :confirm, :create, :index, :show, :complete]

  def new
    @order = Order.new
  end

  def confirm
    # ryon
    # 新しい注文オブジェクトを作成
    @order = Order.new
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order.postage = 800  #送料800円で固定
    # フォームから送信された注文の支払い方法を受け取り
    @selected_payment_method = params[:order][:payment_method]
    # 以下、商品合計額の計算
    # 空の配列作成
    # 各カートアイテムの価格と数量の金額を格納するのに使用
    ary = []
    # 商品の価格×数量＝金額(ary配列に追加)
    @cart_items.each do |cart_item|
      ary << cart_item.item.with_tax_price*cart_item.amount
    end
     # ary.sumですべてのカートアイテムの金額を計算し、＠cart_items_priceに設定
    @cart_items_price = ary.sum
    # 支払い合計金額＝送料＋カート内商品の合計金額
    @order.total_payment = @order.postage + @cart_items_price
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
        @selested_address = params[:order][:new_post_code] + " " + params[:order][:new_address] + " " + params[:order][:new_name]
      else
        render :new #エラー時には新しいページへ
      end
    end
  end

  def create
    #ryon
    @order = Order.new
    #現在ログインしているユーザーのID
    @order.customer_id = current_customer.id
    @order.payment_method = params[:order][:payment_method]
    # フォームから支払い方法を取得
    @order.postage = 800 #固定送料
    #カート内の全ての商品を取得
    @cart_items = CartItem.where(customer_id: current_customer.id)
    # 空の配列作成
    # 各カートアイテムの価格と数量の金額を格納するのに使用
    ary = []
    # 商品の価格×数量＝金額(ary配列に追加)
      @cart_items.each do |cart_item|
      ary << cart_item.item.with_tax_price*cart_item.amount
      end
      # ary.sumですべてのカートアイテムの金額を計算し、＠cart_items_priceに設定
      @cart_items_price = ary.sum
      #送料とカートアイテムの合計金額
      @order.total_payment = @order.postage + @cart_items_price
      # ユーザーが選択した支払い方法を設定
      @order.payment_method = params[:order][:payment_method]
      if @order.payment_method == "credit_card"
        @order.status = 0 #クレジットカード
      else
        @order.status = 1 #銀行振込
      end

      address_type = params[:order][:address_type]
      #address_typeに応じて異なる配送先情報を@oederに設定
    case address_type
    when "customer_address" #カスタマーの登録住所を@orderに設定
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    #フォームから送信されたregistered_address_idを使用し、登録済み住所情報をselectedに取得し、@orderに設定
    when "registered_address"
      Address.find(params[:order][:registered_address_id])
      selected = Address.find(params[:order][:registered_address_id])
      @order.post_code = selected.post_code
      @order.address = selected.address
      @order.name = selected.name
    #フォームから送信された新しい住所情報を@orderに設定
    when "new_address"
      @order.post_code = params[:order][:new_post_code]
      @order.address = params[:order][:new_address]
      @order.name = params[:order][:new_name]
    end


    if @order.save
    #saveが成功したら
      if @order.status == 0
      #製造ステータスが未着手である
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 0)
        end
      else #０以外の場合→製造開始である
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 1)
        end
      end
      # 注文処理後、カート内を全て削除
      @cart_items.destroy_all
      # 注文正常処理後、注文完了を知らせる
      redirect_to orders_complete_path
    else #注文処理失敗
      # 他のviewを表示しエラーメッセージを表示
      render :new
    end
  end


  def complete
  end

  def index
    #ryon
    #where〜 ログイン中の会員の注文のみを取得
    #order(created_at: :desc) で最新の注文が最初に表示される
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc).page(params[:page]).per(10)
    # 顧客の注文履歴
    @index = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end

end