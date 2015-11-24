class StaticPagesController < ApplicationController
  def home
  end

  def products
    params[:page] ||= 1
    pri_products = get_products(params.permit(:page, :codStore, :codCategory, :filterOnSale, :filterPoints, :pageLength))
    if pri_products
      @products = WillPaginate::Collection.create(params[:page], pri_products['pageSize'], pri_products['numResults']) do |pager|
        pager.replace(pri_products['products'])
      end
      #render :json => @products
    else
      redirect_to home_path
    end
  end

end
