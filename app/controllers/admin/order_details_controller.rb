class OrderDetailsController < ApplicationController

def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to new_admin_session_path(@customer.id)
end
end