class Public::ItemsController < ApplicationController
 before_action :authenticate_customer!, except:[:index]

 def index
   @items = Item.page(params[:page]).per(8)
   @items_amount = Item.all
 end

 def show
   @item = Item.find(params[:id])

   @cart_item = CartItem.new

 end



end
