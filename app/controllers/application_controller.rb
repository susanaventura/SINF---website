class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  include PrimaveraIntegrationHelper
  include ImagesHelper
  
  before_filter :get_primavera_global_info
  def get_primavera_global_info
    @categories = get_categories
    @stores = get_stores
  end


end
