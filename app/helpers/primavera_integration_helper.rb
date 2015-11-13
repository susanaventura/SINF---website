module PrimaveraIntegrationHelper
  require 'net/http'

  def get_categories
	JSON.parse send_get('categories').body
	
  end


  
  private
  
  def primavera_path(url)
	'http://localhost:49275/api/'+url
  end
  
  def send_get(resource)
  
	url = URI.parse(primavera_path(resource))
	req = Net::HTTP::Get.new(url.to_s)
	
	puts 'Sending GET request to ' + url.to_s
	
	Net::HTTP.start(url.host, url.port) {|http|
		http.request(req)
	}
  end
  
end
