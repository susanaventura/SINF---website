class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:checkout_preview, :user]

  def show
    @order = get_order(params.to_param)
    params.to_param
  end

  def checkout_overview
  end

  def checkout_preview
    if cart_empty?
      redirect_to checkout_overview_path
    end
    if @cart['total_points'] > current_user.current_points
      flash[:danger] = 'You do not have enough points to make this purchase'
      redirect_to checkout_overview_path
    end
  end

  def create
    user = find_user_with_pri_info(current_user.id)
    cart = get_cart

    if user && user.current_points >= cart['total_points'] && cart && post_order(user,cart)
      new_points = (@cart['subtotal'] + @cart['total_iec'] + @cart['total_iva']).floor
      user.update_attribute(:current_points, user.current_points - cart['total_points'] + new_points)
      session.delete :cart
      get_cart
      redirect_to user_path(current_user)
    else
      flash[:danger] = 'Error submiting order. Please try again later'
      redirect_back_or root_url
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

  def redirect_back_or(url)
    request.env["HTTP_REFERER"] ||= url
    redirect_to :back
  end


end