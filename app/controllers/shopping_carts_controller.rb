class ShoppingCartsController < ApplicationController

  def add_item
    if (item = get_product(params[:item]))
     cart_add_item(item, params[:points])
    end
    redirect_back_or root_url
  end

  def remove_item
    cart_remove_item(params[:item])
    redirect_back_or root_url
  end

  def update
    cart_set(params.require(:cart))
    redirect_back_or root_url
  end

  def clear
    session.delete(:cart)
    get_cart
    redirect_back_or root_url
  end

  def test
    get_cart
    render :json => JSON.pretty_generate(@cart)
    #products = get_products({})
    #session.delete(:cart)
    #get_cart
    #cart_add_item(products['products'].first)
    #render :json => @cart

  end

  private

  def redirect_back_or(url)
    request.env["HTTP_REFERER"] ||= url
    redirect_to :back
  end
end
