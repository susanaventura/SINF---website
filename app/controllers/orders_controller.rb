class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:checkout_preview]


  def checkout_overview

  end

  def checkout_preview
    if cart_empty?
      redirect_to checkout_overview_path
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