class StaticPagesController < ApplicationController
  def home
    @products_on_sale = OnlineStoreWeb::Application::STATIC_ASSETS[:products_on_sale]['products']
    @products_last_sold = get_products(filterLastSold: true, pageLength: 3)['products']
    @products_new = get_products(sortDate: true, pageLength: 3)['products']
  end

  def products
    params[:page] ||= 1
    pri_products = get_products(params.permit(:page, :codStore, :codCategory, :filterOnSale, :filterPoints, :pageLength, :searchString, :filterLastSold, :sortDate))
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
    @related_products = get_products(codCategory: @product['Category'], pageLength: 3)['products'].reject { |h| @product['CodProduct'].include? h['CodProduct'] }
  end

  def stores_index
    @store_products = {}
    @stores.each do |_, store|
      @store_products[store['id']] = get_products(codStore: store['id'], pageLength: 3)['products']
    end
  end

  def points_store
    #@user = find_user_with_pri_info(params[:session][:username])
    params[:page] ||= 1
    pri_products = get_products(params.permit(:page, :filterPoints))
    if pri_products
      @products = WillPaginate::Collection.create(params[:page], pri_products['pageSize'], pri_products['numResults']) do |pager|
        pager.replace(pri_products['products'])
      end
      render "static_pages/products.html.erb"
    else
      redirect_to home_path
    end
  end



end

