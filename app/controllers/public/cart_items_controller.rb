class Public::CartItemsController < ApplicationController

  def index
    @cart_item = CartItem.where(customer_id: current_customer.id)
    @total = @cart_item.inject(0) {|sum,item| sum + item.subtotal }
  end

  def update
    @cart_item = CartItem.where(customer_id: current_customer.id)
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.where(customer_id: current_customer.id)
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    cart_item = CartItem.where(customer_id: current_customer.id)
    cart_item.destroy_all
    redirect_to cart_items_path
  end

  def create

   cart_item = CartItem.new(cart_item_params)
   cart_item.save
   redirect_to cart_items_path
  end

 private

 def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
 end
end
