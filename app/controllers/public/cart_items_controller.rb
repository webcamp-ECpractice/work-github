class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_item = CartItem.where(customer_id: current_customer.id)
    @total = @cart_item.inject(0) {|sum,item| sum + item.subtotal }
  end

  def update
    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    cart_item = CartItem.where(customer_id: current_customer.id)
    cart_item.destroy_all
    redirect_to cart_items_path
  end

  def create
    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])

    if @cart_item
      @cart_item.amount += CartItem.new(cart_item_params).amount
      @cart_item.save
      redirect_to cart_items_path
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.save
      redirect_to cart_items_path
    end
  end

 private

 def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
 end
end
