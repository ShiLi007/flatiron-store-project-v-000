class LineItemsController < ApplicationController

  def new
  end

  def create
    initialize_cart
    item = Item.find(params[:item_id])
    @line_item = current_cart.add_item(item.id)
    
    if @line_item.save
      redirect_to cart_path(current_cart), alert: "Added Item to Cart!"
    else 
      redirect_to store_path, alert: "Error Adding Item."
    end
  end

end

