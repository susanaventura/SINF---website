class StaticPagesController < ApplicationController
  def home
    @products_on_sale = get_products(filterOnSale: true, pageLength: 3)['products']
  end

  def products
    params[:page] ||= 1
    pri_products = get_products(params.permit(:page, :codStore, :codCategory, :filterOnSale, :filterPoints, :pageLength, :searchString))
    if pri_products
      @products = WillPaginate::Collection.create(params[:page], pri_products['pageSize'], pri_products['numResults']) do |pager|
        pager.replace(pri_products['products'])
      end
      #render :json => @products
    else
      redirect_to home_path
    end
  end
  
  def product
	prod_id = params[:id]
	@info = get_product(prod_id)
	if !@info
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

