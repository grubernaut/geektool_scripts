#!/usr/bin/ruby
require 'rubygems'
require 'json'
require 'net/http'
require 'uri'

uri = URI.parse("http://api.bitcoincharts.com/v1/markets.json")

http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)

if response.code == "200"
	result = JSON.parse(response.body)

	result.each do |doc|
		#puts doc["symbol"]
		#puts doc
		#puts ""
		#puts ""
		symbol = doc["symbol"]

		if symbol == "bitstampUSD" || symbol == "bitfinexUSD" || symbol == "btceUSD" || symbol == "localbtcUSD"
			puts "Market -> #{symbol}"
			puts "\tHighest -> %.2f" % doc["high"].to_f
			puts "\tAverage -> %.2f" % doc["avg"].to_f
			puts "\tLowest -> %.2f" % doc["low"].to_f
			puts "\tLatest -> %.2f" % doc["bid"].to_f
			puts "\tNetWorth -> %.2f" % doc["currency_volume"].to_f
			puts ""
		end
	end
else
	puts "ERROR"
end
