# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  #before_action :customer_state, only: [:create]

  protected
  # 退会しているかを判断するメソッド
  def customer_state
  ## 【処理内容1】 入力されたemailからアカウントを1件取得
       @customer = Customer.find_by(email: params[:customer][:email])
      ## アカウントを取得できなかった場合、このメソッドを終了する
      return if !@customer
      ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別


      #if @customer.is_deleted
       # redirect_to new_customer_registration_path
      #else
       #  if @customer.valid_password?(params[:customer][:password])
        ## 【処理内容3】
        #redirect_to customer_session_path
        #else
        #redirect_to new_customer_session_path
         #end
      #end

      if !@customer.is_deleted && @customer.valid_password?(params[:customer][:password])
        redirect_to customer_session_path
      else
        redirect_to new_customer_session_path
      end
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end
  def after_sign_in_path_for(resource)
   public_customer_path(current_customer)
  end


  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  def after_sign_out_path_for(resource)
    public_root_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end