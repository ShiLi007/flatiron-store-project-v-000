class CartsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_cart, only: [:checkout]

  def show
    @cart = Cart.find(params[:id])
  end

  def checkout
    @cart = Cart.find(params[:id])
    @cart.checkout

    current_user.current_cart = nil
    if @cart.save && current_user.save
      flash[:alert] = "Order Submitted!"
      redirect_to cart_path(@cart)
    end
  end

  private 

  def set_cart
    @cart = current_user.current_cart
    redirect_to store_path if @cart.nil?
  end

end
