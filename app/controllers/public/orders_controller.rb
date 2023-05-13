class Public::OrdersController < ApplicationController
  def new
    @order = Order.new

  end

  def confirm_orders
    @order = Order.new(order_params)

    @cart_item = CartItem.where(customer_id: current_customer.id)
    @total_payment = @cart_item.total_price(@cart_item) + @order.postage

    if params[:order][:address_select].to_i== 1
      # current_customerから取得する処理
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name_address = current_customer.first_name + current_customer.last_name

    elsif params[:order][:address_select].to_i == 2
      # Addressから取得
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name_address = @address.name

    elsif params[:order][:address_select].to_i == 3
      # 入力された値を入れる処理
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name_address = params[:order][:name_address]
    end
  end

  def create
    cart_items = current_customer.cart_items.all

    @address = Address.find_by(address: params[:order][:address_id])
    @payment_method = Order.find_by(payment_method: params[:order][:payment_method])

    @order = current_customer.orders.new(order_params)
    @order.save

    cart_items.each do |cart_item|

      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item_id
      order_detail.order_id = @order.id
      order_detail.items_amount = cart_item.amount
      order_detail.unit_price = cart_item.item.price

      order_detail.save

    end
    cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def complete

  end

  def index
    @orders = current_customer.orders.all
    @order_details = current_customer.order_details

  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all

  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name_address,:payment_amount, :postage)
  end

end