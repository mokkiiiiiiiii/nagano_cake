class Public::CustomersController < ApplicationController
  before_action :correct_customer, only: [:edit, :update]

  def show
    @customer = current_customer
    #@customer = Customer.new
  end

  def edit
    @customer = current_customer
  end

  def check
    @customer = current_customer
    @customer = Customer.all
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    if @customer.save
    redirect_to public_customer_path(@customer.id)
    end
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    redirect_to public_root_path
  end

private

  def customer_params
    params.require(:customer).permit(:name, :email)
  end

  def correct_customer
    @customer = Customer.find(params[:id])
    redirect_to public_customer_path(current_customer) unless @customer == current_customer
  end
end