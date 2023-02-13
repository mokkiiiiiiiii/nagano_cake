class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def create
    if nil != current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.amount += params[:cart_item][:amount].to_i
      @cart_item.update(amount: @cart_item.amount)
      redirect_to public_cart_items_path
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      @cart_item.save
      redirect_to public_cart_items_path
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to public_cart_items_path(@cart_item.id)
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
  @cart_item = current_customer.cart_items
  @cart_item.destroy_all
  redirect_to public_cart_items_path
  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount, :with_tax_price, :subtotal)
  end

end
