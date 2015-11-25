class StaticPagesController < ApplicationController
  def home
    @products_on_sale = OnlineStoreWeb::Application::STATIC_ASSETS[:products_on_sale]['products']
  end

  def products
    params[:page] ||= 1
    pri_products = get_products(params.permit(:page, :codStore, :codCategory, :filterOnSale, :filterPoints, :pageLength, :searchString))
    if pri_products
      @products = WillPaginate::Collection.create(params[:page], pri_products['pageSize'], pri_products['numResults']) do |pager|
        pager.replace(pri_products['products'])
      end
    else
      redirect_to home_path
    end
  end
  
  def product
    @product = get_product(params[:id])
    if !@product
      redirect_to home_path
    end
  end

  def stores_index
    @store_products = {}
    @stores.each do |store|
      @store_products[store['id']] = get_products(codStore: store['id'], pageLength: 3)['products']
    end
  end
end

