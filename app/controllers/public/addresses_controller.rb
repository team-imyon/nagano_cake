class Public::AddressesController < ApplicationController
  def index
    @customer = current_customer
    @address = @customer.addresses
    @naddress = Address.new
  end
  
  def create
    @naddress = Address.new(address_params)
    @naddress.customer_id = current_customer.id
    if @naddress.save
      flash[:notice] = "登録が完了いたしました"
      redirect_to addresses_path
    else
      @customer = current_customer
      @address = @customer.addresses
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "変更が完了いたしました"
      redirect_to addresses_path
    else
      render :edit
    end
  end
  
  def destroy
    address = Address.find(params[:id])
    address.destroy
      flash[:notice] = "削除が完了いたしました"
    redirect_to addresses_path
  end
  
  private
  
    def address_params
    params.require(:address).permit(:post_code, :address, :name)

  end
end

