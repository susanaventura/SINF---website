module PrimaveraIntegrationHelper
  require 'net/http'

  def get_categories
    categories = {}
    parse_res(send_get('categories'), []).each do |category|
      categories[category['code']] = category
    end
    return categories
  end

  def get_stores
    stores = {}
    parse_res(send_get('stores'), []).each do |store|
      stores[store['id']] = store
    end
    return stores
  end


  def get_client(id)
    parse_res(send_get("clients/#{id}"), nil)
  end

  def get_product(id)
    parse_res(send_get("products/#{id}"), nil)
  end

  def get_products(params)
    parse_res(send_get("products?#{params.to_query}"), {'products' => []})
  end


  def post_client(user)
    parse_res(send_post('clients', user_to_json(user)), nil, '201')
  end

  def put_client(user)
    check_res(send_put('clients', user_to_json(user)), '200')
  end

  def post_order(user, cart)
    check_res(send_post('orders', order_to_json(user,cart)), '201')
  end

  def get_static_assets
    last_update = OnlineStoreWeb::Application::STATIC_ASSETS[:last_update]
    if (last_update && last_update < 24.hours.ago)
      OnlineStoreWeb::Application::STATIC_ASSETS.clear
    end
    OnlineStoreWeb::Application::STATIC_ASSETS[:last_update] ||= Time.zone.now

    OnlineStoreWeb::Application::STATIC_ASSETS[:categories] ||= get_categories
    OnlineStoreWeb::Application::STATIC_ASSETS[:stores] ||= get_stores
    OnlineStoreWeb::Application::STATIC_ASSETS[:products_on_sale] ||= get_products(filterOnSale: true, pageLength: 3)
  end


  def get_user_orders(user)
    parse_res(send_get("orders?codClient=#{user}"), {'orders' => []})
    #parse_res(send_get("orders?codClient=SILVA"), {'orders' => []})
  end

  def get_order(id)
    parse_res(send_get("orders?#{id}"), nil)
  end


  private

    # Returns the path to the Primavera API
    def primavera_path(url)
      'http://localhost:49275/api/'+url
    end

    # Sends a GET request to a primavera resource
    def send_get(resource)

      url = URI.parse(primavera_path(resource))
      req = Net::HTTP::Get.new(url.to_s)

      puts 'Sending GET request to ' + url.to_s

      send_request(url, req)
    end

    # Sends a POST request to a primavera resource
    def send_post(resource, data)

      url = URI.parse(primavera_path(resource))
      req = Net::HTTP::Post.new(url.to_s, initheader = {'Content-Type' => 'application/json'})
      req.body = data

      puts 'Sending POST request to ' + url.to_s

      send_request(url, req)
    end

    # Sends a PUT request to a primavera resource
    def send_put(resource, data)

      url = URI.parse(primavera_path(resource))
      req = Net::HTTP::Put.new(url.to_s, initheader = {'Content-Type' => 'application/json'})
      req.body = data

      puts 'Sending PUT request to ' + url.to_s

      send_request(url, req)
    end

    # Aux function to send a request and catch exceptions
    def send_request(url, req)
      begin
        Net::HTTP.start(url.host, url.port, :read_timeout => 180) {|http| http.request(req)}
      rescue Errno::ECONNREFUSED, Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
        puts e.to_s
        nil
      end
    end

    # Parses a JSON HTTP response, in case of failure returns a default value
    def parse_res(res, default, success_code='200')
      if res && res.code == success_code
        begin
          JSON.parse res.body
        rescue JSON::ParserError
          default
        end
      else
        default
      end
    end

    def check_res(res, success_code='200')
      return  res && res.code == success_code
    end

    # {"codClient":"SUSANA", "name":"coiso", "email":"fsdfs", "address":"sdfsdf", "postal_addr":"4444-123", "op_zone":"0", "local":"Porto", "taxpayer_num":"123456789", "currency":"EUR"}
    def user_to_json(user)
      {
          'codClient' => user.username,
          'name' => user.name,
          'email' => user.email,
          'address' => user.address,
          'postal_addr' => user.postal_address,
          'op_zone' => '0',
          'local' => user.local,
          'taxpayer_num' => user.taxpayer_num,
          'currency' => 'EUR'
      }.to_json
    end

    def order_to_json(user, cart)
      address = "#{user.address}, #{user.postal_address} #{user.local}"
      order = {
          'CodClient' => user.username,
          'Date' => Time.zone.now.strftime('%FT%T'),
          'DeliveryAddress' => address,
          'BillingAddress' => address,
          'Items' => []
      }
      cart['items'].each do |_,item|
        order['Items'] << {
            'CodProduct' => item['CodProduct'],
            'Quantity' => item['quantity'],
            'ValorIEC' => item['IECValue'] || 0,
            'DiscountPerc' => item['Discount'],
            'TotalDiscount' => item['product_total_discount'],
            'DiscountUnit' => item['discount_unit'],
            'UnitPrice' => item['Price']
        }
      end
      return order.to_json
    end
end
