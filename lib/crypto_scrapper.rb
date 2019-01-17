require 'rubygems'
require 'nokogiri'
require 'open-uri'

# page = Nokogiri::HTML(open("http://en.wikipedia.org/"))
# puts page.class   # => Nokogiri::HTML::Document

# page = Nokogiri::HTML(open('http://en.wikipedia.org/wiki/HTML'))
# page.css('div#content div#bodyContent table.infobox tr th').each do |el|
#    puts el.text
# end

page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))

def get_cryptoname(url)
  cryptoname =[]
 url.xpath('//tbody//td//span//a').each do |el|
   cryptoname << el.text
 end
 return cryptoname
end

def get_price(url)
  price =[]
 url.xpath('//td[5]//a').each do |el|
   price << el.text[1..-1].to_f
 end
  return price
end


def crypto_price_array(url)
  crypto_value = get_cryptoname(url).zip(get_price(url))
  final_array =[]
  crypto_value.each do |e|
    final_array << { e[0] => e[1]}
  end
  return final_array.inspect
end

puts crypto_price_array (page)
