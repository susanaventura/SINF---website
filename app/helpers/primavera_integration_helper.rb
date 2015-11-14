module PrimaveraIntegrationHelper
  require 'net/http'

  def get_categories
	  if (res = send_get('categories'))
      JSON.parse res.body
    else
      {}
    end
  end


  private
  
    def primavera_path(url)
      'http://localhost:49275/api/'+url
    end

    def send_get(resource)

      url = URI.parse(primavera_path(resource))
      req = Net::HTTP::Get.new(url.to_s)

      puts 'Sending GET request to ' + url.to_s

      begin
        response = Net::HTTP.start(url.host, url.port) {|http|
          http.request(req)
        }
      rescue Errno::ECONNREFUSED, Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError
        response = nil
      end

      response
    end
  
end
