class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
    @order_details = @order.order_details
    @total = @order_details.inject(0) {|sum,order| sum + order.subtotal }
  end

  def customer_order
    @customer = Customer.find(params[:id])
    @orders = @customer.orders.page(params[:page])
  end


  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])

    if @order.update(order_params)
      @order_details.update_all(is_maked: 2) if @order.is_ordered == "ok_payment"
    ## ①注文ステータスが「入金確認」とき、製作ステータスを全て「製作待ち」に更新する
    end
  redirect_to admin_order_path(@order)
end

private
  def order_params
    params.require(:order).permit(:is_ordered)
  end

end