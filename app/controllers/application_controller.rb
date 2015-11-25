class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  include ShoppingCartsHelper
  include PrimaveraIntegrationHelper
  include ImagesHelper

  
  before_filter :init_assets
  def init_assets
    @cart = get_cart

    get_static_assets
    @categories = OnlineStoreWeb::Application::STATIC_ASSETS[:categories]
    @stores = OnlineStoreWeb::Application::STATIC_ASSETS[:stores]
  end


end
