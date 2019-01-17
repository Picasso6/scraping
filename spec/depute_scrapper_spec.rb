require_relative '../lib/depute_scrapper'

describe "the get_name_depute method" do
	noko = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
	it "contain Damien Abad" do
		expect(get_name_depute(noko).include?("Damien Abad")).to eq(true)
	end
	it "should not be a string" do
		expect(get_name_depute(noko).instance_of?String).to eq(false)
	end
end
