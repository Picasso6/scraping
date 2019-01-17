require 'rubygems'
require 'nokogiri'
require 'open-uri'


page_mairie_arronville = Nokogiri::HTML(open('http://annuaire-des-mairies.com/95/arronville.html'))
annuaire_valdoise = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))

def get_townhall_email(townhall_url)
  return townhall_url.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
end
#puts get_townhall_email(page_mairie_arronville)

def get_townhall_name(annuaire)
    town_list =[]
    annuaire.xpath('//p/a').each do |el|
    town_list << el.text
    end
    return town_list
end

def get_townhall_url(annuaire)
  town_list_url =[]
  annuaire.xpath('//p/a').each do |el|
  url = "https://www.annuaire-des-mairies.com#{el.attr('href')[1..-1]}"
  town_list_url << url
  end
  return town_list_url
end

def get_town_list_mail(annuaire)
  puts "Veuillez patienter pendant le scrapping ..."
  town_list_mail =[]
  get_townhall_url(annuaire).each do |e|
    adr = Nokogiri::HTML(open(e))
    mail = adr.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    town_list_mail << mail
  end
  return town_list_mail
end
#puts get_town_list_mail(annuaire_valdoise)

def get_city_email_final(annuaire)
town_with_mail = get_townhall_name(annuaire).zip(get_town_list_mail(annuaire))
final_array = []
  town_with_mail.each do |e|
      final_array << {e[0] => e[1]}
  end
  return final_array
end

puts get_city_email_final(annuaire_valdoise).inspect
