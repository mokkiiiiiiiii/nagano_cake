class Public::CustomersController < ApplicationController
  before_action :correct_customer, only: [:edit, :update]

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = "顧客情報を編集しました"
      redirect_to public_customers_show_path(@customer.id)
    else
      flash.now[:denger] = "顧客情報編集に失敗しました"
      render :edit
    end
  end
  
  def check
    @customer = current_customer
  end
  
  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to public_root_path
  end

private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number,:active)
  end

  def correct_customer
    @customer = Customer.find(params[:id])
    redirect_to admin_customers_path(current_customer) unless @customer == current_customer
  end
end