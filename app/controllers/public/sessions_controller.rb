# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
before_action :customer_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_out_path_for(resource)
    root_path
  end

protected
# 退会しているかを判断するメソッド
  def customer_state
    # 入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer
    # 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
      if @customer.valid_password?(params[:customer][:password]) && !@customer.is_active
      #一致してるかつ退会してたら（!〇〇.is_active=有効状態の反転）
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_customer_registration_path
      else
          flash[:notice] = "項目を入力してください"
      end
    end

  end

end
