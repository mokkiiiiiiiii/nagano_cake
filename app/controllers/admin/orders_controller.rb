class Admin::OrdersController < ApplicationController

   def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = 0
   end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to new_admin_session_path(@customer.id)
  end
  private
  def order_params
  params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
end