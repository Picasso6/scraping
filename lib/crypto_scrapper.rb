require 'rubygems'
require 'nokogiri'
require 'open-uri'

def crypto_scrapper

  page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
#GET NAMES OF CRYPTOMONNEYS ARRAY
  cryptoname =[]
   page.xpath('//tbody//td//span//a').each do |el|
     cryptoname << el.text
   end
#GET PRICE ARRAY
  price_arr =[]
  page.xpath('//td[5]//a').each do |el|
   price_arr << el.text[1..-1].to_f
  end
#FUSION PRICES & NAMES
  crypto_value = cryptoname.zip(price_arr)
  final_array =[]
  crypto_value.each do |e|
    final_array << { e[0] => e[1]}
  end
  return final_array
end

#puts final_array
puts crypto_scrapper.inspect
