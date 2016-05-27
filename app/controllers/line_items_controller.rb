class LineItemsController < ApplicationController

  def create
    if !current_cart
      @user = current_user
      @user.current_cart = Cart.create(user_id: @user.id)
      line_item = @user.current_cart.add_item(params[:item_id])
      line_item.save
    else
      @user = current_user
      line_item = @user.current_cart.add_item(params[:item_id])
      line_item.save
    end
    redirect_to cart_path(current_cart)
  end

end
