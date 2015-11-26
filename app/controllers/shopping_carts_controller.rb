class ShoppingCartsController < ApplicationController

  def add_item
    if (item = get_product(params[:item]))
      cart_add_item(item)
    end
    redirect_to :back
  end

  def remove_item
    cart_remove_item(params[:item])
    redirect_to :back
  end

  def update
    cart_set(params.require(:cart))
    redirect_to :back
  end

  def clear
    session.delete(:cart)
    get_cart
    redirect_to :back
  end

  def test
    #get_cart
    #render :json => @cart

    products = get_products({})
    session.delete(:cart)
    get_cart
    cart_add_item(products['products'].first)
    render :json => @cart

  end

end
