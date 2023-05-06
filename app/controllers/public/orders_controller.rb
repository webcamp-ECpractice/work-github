class Public::OrdersController < ApplicationController

  def index

  end

  def new
    @order = Order.new
    
  end
  
end
