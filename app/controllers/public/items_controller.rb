class Public::ItemsController < ApplicationController

 def index
   @items = Item.page(params[:page]).per(8)
   @items_amount = Item.all
 end

 def show
   @item = Item.find(params[:id])
   @item_n
 end

 private

 def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
 end

end
