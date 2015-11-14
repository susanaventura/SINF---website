class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  include PrimaveraIntegrationHelper

  
  before_filter :set_categories
  def set_categories
    @categories = get_categories
  end
end
