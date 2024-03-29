class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:points_store]

  def home
    @products_on_sale = OnlineStoreWeb::Application::STATIC_ASSETS[:products_on_sale]['products']
    @products_last_sold = get_products(sort: 'lastsold', pageLength: 3)['products']
    @products_new = get_products(sort: 'datenewest', pageLength: 3)['products']
  end

  def products
    if params[:filterPoints]
      logged_in_user
    end

    params[:page] ||= 1
    pri_products = get_products(params.permit(:page, :codStore, :codCategory, :filterOnSale, :filterPoints, :pageLength, :searchString, :sort))
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
    @images = get_images_for_product(@product)
    @related_products = get_products(codCategory: @product['Category'], pageLength: 4, sort: 'lastsold')['products'].reject { |h| @product['CodProduct'].include? h['CodProduct'] }
    @related_products = @related_products.slice(0,3)
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

private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

end

