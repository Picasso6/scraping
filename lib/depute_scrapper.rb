require 'rubygems'
require 'nokogiri'
require 'open-uri'

annuaire_depute = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))

#def get_name_depute(annuaire)

name_depute =[]
annuaire_depute.xpath('/html/body/div[3]/div/div/section/div/article/div[3]/div/div/div/ul//li/a').each do |e|
  if e.content.start_with?("M.")
    name_depute << e.content[3..-1]
  elsif e.content.start_with?("Mme")
    name_depute << e.content[4..-1]
  else
    name_depute << e.content
  end
  puts name_depute
end






# /html/body/div[3]/div/div/section/div/article/div[3]/div/div[3]/div[6]/ul[1]/li[2]/a
#
# /html/body/div[3]/div/div/section/div/article/div[3]/div/div[3]/div[6]/ul[1]/li[3]/a
