class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  include ShoppingCartsHelper
  include PrimaveraIntegrationHelper
  include ImagesHelper

  
  before_filter :set_global_sets
  def set_global_sets
    @cart = get_cart
    @categories = get_categories
    @stores = get_stores
  end


end
