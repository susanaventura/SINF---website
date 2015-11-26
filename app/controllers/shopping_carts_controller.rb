class ShoppingCartsController < ApplicationController

  def add_item
    cart_add_item(params[:item])
    redirect_to checkout_overview_path
  end

  def remove_item
    cart_remove_item(params[:item])
    redirect_to checkout_overview_path
  end

  def update

  end

  def clear
    session.delete(:cart)
    get_cart
    redirect_to root_path
  end

  def test
    get_cart
    render :json => @cart
  end

end
