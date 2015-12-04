module ShoppingCartsHelper

  def get_cart
    session[:cart] ||= {}
    session[:cart]['items'] ||= {}
    session[:cart]['subtotal'] ||= 0.0
    session[:cart]['total_discount'] ||= 0.0
    session[:cart]['total_items'] ||= 0
    session[:cart]['total_iec'] ||= 0.0
    session[:cart]['total_iva'] ||= 0.0


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

  def cart_set(items)
    get_cart
    items.each do |item, quantity|
      if (quantity.to_i == 0)
        session[:cart]['items'].delete(item)
      elsif (session[:cart]['items'][item])
        session[:cart]['items'][item]['quantity'] = quantity.to_i
      end
    end

    cart_update_totals
  end

  def cart_update_totals
    subtotal = 0
    total_iec = 0
    total_iva = 0
    total_discount = 0
    total_items = 0

    cart = get_cart

    cart['items'].each do |key, product|
      quantity = product['quantity']
      price_unit = product['Price']
      discount_perc = product['Discount']
      discount_unit = price_unit * discount_perc/100.0
      iva_perc = product['IVAValue']
      iva_unit = (iva_perc/100.0)*(price_unit-discount_unit)
      valor_iec = product['IECValue']

      product_total_liquid = quantity * (price_unit-discount_unit)
      product_total_discount = quantity * discount_unit
      product_total_iva = quantity * iva_unit

      subtotal += product_total_liquid
      total_iva += product_total_iva
      total_discount += product_total_discount
      total_iec += quantity * valor_iec
      total_items += quantity

      cart['items'][key]['discount_unit'] = discount_unit
      cart['items'][key]['iva_unit'] = iva_unit
      cart['items'][key]['product_total_liquid'] = product_total_liquid
      cart['items'][key]['product_total_discount'] = product_total_discount
      cart['items'][key]['product_total_iva'] = product_total_iva
    end

    session[:cart]['subtotal'] = subtotal
    session[:cart]['total_iec'] = total_iec
    session[:cart]['total_iva'] = total_iva
    session[:cart]['total_discount'] = total_discount
    session[:cart]['total_items'] = total_items

  end


end
