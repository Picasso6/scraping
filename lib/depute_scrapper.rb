require 'rubygems'
require 'nokogiri'
require 'open-uri'

list_depute = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))

#OBTENTION DES NOMS DE DÉPUTÉS
def get_name_depute(annuaire)
  name_depute =[]
  annuaire.xpath('/html/body/div[3]/div/div/section/div/article/div[3]/div/div/div/ul//li/a').each do |e|
    if e.content.start_with?("M.")
      name_depute << e.content[3..-1]
    elsif e.content.start_with?("Mme")
      name_depute << e.content[4..-1]
    else
      name_depute << e.content
    end
  end
  return name_depute
end

#puts get_name_depute(list_depute).inspect

#METHODE 1 (DEDUCTION DES MAILS)
# final_arr = []
# get_name_depute(list_depute).each do |e|
#   arr = e.split
#   first_name = arr[0]
#   last_name = ""
#   mailbegin= "#{first_name}."
#   arr[1..-1].each do |i|
#     last_name << i
#     last_name << " "
#     mailbegin << i
#   end
#   final_arr << { "first_name" => "#{first_name}",
#   	             "last_name" => "#{last_name[0..-2]}",
#                   "email" => "#{mailbegin.downcase}@assemblee-nationale.fr" , }
# end
#
# puts final_arr.inspect

#CAS PARTICULIER : OBTENIR LE MAIL D'UN DÉPUTÉ UNIQUEMENT
# id_card = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA720568"))
# mail = id_card.xpath('/html/body/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[1]/a').attr('href')
# mail = mail.to_s[7..-1]
# puts mail

#OBTENTION DES URLS RELATIFS AUX FICHES PERSONNELLES DES DÉPUTÉS
def get_depute_url(annuaire)
  depute_list_url =[]
  annuaire.xpath('/html/body/div[3]/div/div/section/div/article/div[3]/div/div/div/ul//li/a').each do |el|
  url = "http://www2.assemblee-nationale.fr/#{el.attr('href')[1..-1]}"
  depute_list_url << url
  end
  return depute_list_url
end
#puts get_depute_url(list_depute)

#OBTENTION LES MAILS DES DÉPUTÉS (NÉCESSITE L'ACTIVATION DE get_depute_url)
def get_mail_depute(annuaire)
  puts "Veuillez patienter pendant le scrapping ..."
  depute_list_mail =[]
  i=0
  get_depute_url(annuaire).each do |e|
    adr = Nokogiri::HTML(open(e))
    email = adr.xpath('/html/body/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li/a').attr('href')
    email = email.to_s[7..-1]
    depute_list_mail << email
    i+=1
    puts "#{i} mails chargés"
    puts email
  end
  return depute_list_mail
end
#puts get_mail_depute(list_depute)

#METHODE 2 (SCRAPPING DES MAILS)
def bottin(annuaire)
  correspondance = get_name_depute(annuaire).zip(get_mail_depute(annuaire))
  final_array = []
  correspondance.each do |e|
      final_array << {e[0] => e[1]}
  end
return final_array
end
puts bottin(list_depute).inspect
