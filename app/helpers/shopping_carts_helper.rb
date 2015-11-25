module ShoppingCartsHelper

  def get_cart
    session[:cart] ||= {}
    session[:cart]['items'] ||= {}
    session[:cart]['total_cost'] ||= 0.0
    session[:cart]['total_discount'] ||= 0.0
    session[:cart]['total_items'] ||= 0

    session[:cart]
  end

  def cart_empty?
    get_cart['items'].count == 0
  end

  def cart_add_item(item)
    get_cart
    i = item['CodProduct']
    session[:cart]['items'][i] ||= item
    session[:cart]['items'][i]['quantity'] ||= 0
    session[:cart]['items'][i]['quantity'] += 1

    cart_update_totals
  end

  def cart_remove_item(item_id)
    get_cart
    session[:cart]['items'].delete(item_id)

    cart_update_totals
  end

  def cart_update_totals
    total_cost = 0
    total_discount = 0
    total_items = 0

    get_cart['items'].each do |_, item|
      total_cost += Float(item['Price']) * item['quantity']
      total_items += item['quantity']
    end

    session[:cart]['total_cost'] = total_cost
    session[:cart]['total_discount'] = total_discount
    session[:cart]['total_items'] = total_items
  end


end
