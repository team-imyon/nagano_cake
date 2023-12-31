class Public::CustomersController < ApplicationController
  #ryon
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "変更が完了いたしました"
      redirect_to customers_my_page_path
    else
      @customer = current_customer
      render :edit
    end
  end

  def quit

    # @customer = Customer.find(params[:id])

  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる

    @customer.update(is_active: false)

    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  private

  def customer_params

    params.require(:customer).permit(:last_name, :first_name, :furigana_last_name, :furigana_first_name, :post_code, :address, :tel_number, :email, :active)
  end


end
