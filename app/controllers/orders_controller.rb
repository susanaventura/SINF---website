class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:checkout_preview, :user]

  def show
    @order = get_order(params.to_param)
    params.to_param

    render json: @order
  end

  def checkout_overview
  end

  def checkout_preview
    if cart_empty?
      redirect_to checkout_overview_path
    end
  end

  def create
    user = find_user_with_pri_info(current_user.id)
    cart = get_cart

    if user && cart && post_order(user,cart)
      session.delete :cart
      get_cart
      redirect_to user_path(current_user)
    else
      flash[:danger] = 'Error submiting order. Please try again later'
      redirect :back
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