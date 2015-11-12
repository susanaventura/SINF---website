require 'net/http'

url = URI.parse('http://localhost:49275/api/products?lastSold=true')
req = Net::HTTP::Get.new(url.to_s)
res = Net::HTTP.start(url.host, url.port) {|http|
	http.request(req)
}

puts res.body