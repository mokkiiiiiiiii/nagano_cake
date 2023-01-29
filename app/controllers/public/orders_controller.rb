class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def check
    @cart_items = current_customer.cart_items
    @total = 0
    @order = Order.new(order_params)
    if params[:order][:select_address] = 1
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] = 2
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    elsif params[:order][:select_address] = 3
    @address = Address.new
    @address.customer_id = current_customer.id
    @address.postal_code = params[:order][:postal_code]
    @address.address = params[:order][:address]
    @address.name = params[:order][:name]
    @address.save
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    end
  end

  def complete
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.save
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.price = cart_item.item.with_tax_price
      @order_detail.amount = cart_item.amount
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to public_orders_complete_path
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @total = 0
    @order = Order.find(params[:id])
  end

  private
  def order_params
  params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment, :customer_id)
  end
end
