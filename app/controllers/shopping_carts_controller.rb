class ShoppingCartsController < ApplicationController

  def add_item
    cart_add_item(params[:item])
    redirect_to :back
  end

  def remove_item
    cart_remove_item(params[:item])
    redirect_to :back
  end

  def update
    cart_set(params.require(:cart))
    #render :json => params
    redirect_to :back
  end

  def clear
    session.delete(:cart)
    get_cart
    redirect_to :back
  end

  def test
    get_cart
    render :json => @cart
  end

end
