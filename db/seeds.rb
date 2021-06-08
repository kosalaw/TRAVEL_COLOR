require 'nokogiri'
require 'open-uri'

Country.destroy_all
User.destroy_all


ARRAY = %w(
Austria
Belgium
Czech\ Republic
Denmark
Finland
France
Germany
Hungary
Latvia
Liechtenstein
Luxembourg
Netherlands
Norway
Russia
Switzerland
Slovakia
Sweden
Turkey
Albania
Azores
Andorra
Armenia
Azerbaijan
Bosnia\ and\ Herzegovina
Bulgaria
Croatia
Cyprus
Estonia
Georgia
Greece
Gibraltar
Ireland
Iceland
Italy
Lithuania
Madeira
Malta
Moldova
Montenegro
Poland
Portugal
Romania
San\ Marino
Serbia
Slovenia
Spain
Ukraine
)


################################################################################
# WANDERLUST scraper
################################################################################
def create_country(raw_text)
  # store content
  content = raw_text
  # find NAME
  match_data = content.match(/^(?<name>.*):/)
  name = 0
  if !match_data.nil?
    name = match_data[:name]
  end

  if !name.nil? && ARRAY.include?(name)

    # find STATUS
    match_data = content.match(/^(?<name>.*):(.*(?<status>(\s?not allowed|\s?not permitted|\s?only|\s?Only|\s?closed|\s?ban|\s?banned|\s?cannot|\s?prohibited).*\.))?/)
    if !match_data.nil?
      status = match_data[:status]
      # puts status
    end

    # find TEST
    match_data = content.match(/^(?<name>.*):((.*(?<test>\d{2} hours))?)/)
    if !match_data.nil?
      test = match_data[:test]
      # puts test
    end

    # find QUARANTINE
    match_data = content.match(/^(?<name>.*):((.*(?<quarantine>(\s?quarantine|\s?self-isolate|\s?isolate).*\d{2} days))?)/)
    if !match_data.nil?
      quarantine = match_data[:quarantine]
      # puts quarantine
    end

    Country.create!({
      name: name,
      content: content,
      status: status,
      test: test,
      quarantine: quarantine
    })
    # puts "--------------------------------------------------------------"
    # puts country
    # puts "--------------------------------------------------------------"
    # return country
  end
end


puts "Scraping from WANDERLUST"
url = "https://www.wanderlust.co.uk/content/coronavirus-travel-updates/"
html_file = URI.open(url).read
noko_doc = Nokogiri::HTML(html_file)

noko_doc.search("ul > li").each do |element|
  raw_text = element.text.strip

  # check if element contains 2 countries info
  match_data = raw_text.match(/^(?<country1>.*:.*)\.(?<country2>.*:.*)\./)
  if !match_data.nil?
    country1 = match_data[:country1]
    country2 = match_data[:country2]
    country2 = country2[1..-1] # for ICELAND only

    create_country(country1)
    create_country(country2)

    # country1 = create_country(country1)
    # country2 = create_country(country2)

    # countries << country1 if (!country1.nil?)
    # countries << country2 if (!country2.nil?)

  else
    create_country(raw_text)
    # country = create_country(raw_text)
    # countries << country if (!country.nil?)
  end
end



################################################################################
# UK GOV scraper
################################################################################
puts "Scraping from UK GOV"
url = "https://www.gov.uk/guidance/red-amber-and-green-list-rules-for-entering-england"
html_file = URI.open(url).read
noko_doc = Nokogiri::HTML(html_file)
# p noko_doc

noko_doc.search("table").each do |element|
  color = element.search("thead > tr > th:nth-child(1)").text.strip.split(" ")[0]

  element.search("tbody > tr").each do |row|
    name = row.search("th").text.strip
    upcoming_changes = row.search("td").text.strip
    # puts "#{color}: #{name} - #{upcoming_changes}"

    if !name.nil? && ARRAY.include?(name)
      country = Country.find_by_name(name)

      country[:color] = color
      country[:upcoming_changes] = upcoming_changes
      puts country
    end
  end
end
################################################################################




# puts 'create countries'

# country_1 = Country.create!(name: 'France',
# iso: 'French',
# status: 'Open',
# quarantine: 'Yes',
# test: 'Yes',
# content: 'La France" redirects here. For other uses of "La France", see Lafrance. For other uses of "France", see France (disambiguation).',
# government_url: 'https://www.gouvernement.fr/en/news',
# color: 'Amber',
# upcoming_changes: 'N/A')

# country_2 = Country.create!(name: 'Italy',
# iso: 'it',
# status: 'Closed',
# quarantine: 'Yes',
# test: 'Yes',
# content: 'Italy applies health-related restriction measures to incoming travellers, which may vary depending on their country of origin.',
# government_url: 'http://www.italia.it/en/useful-info/covid-19-updates-information-for-tourists.html',
# color: 'Red',
# upcoming_changes: 'N/A')

# country_3 = Country.create!(name: 'Germany',
# iso: 'German',
# status: 'Closed',
# quarantine: 'Yes',
# test: 'No',
# content: 'This article is about the country. For other uses, see Germany (disambiguation) and Deutschland (disambiguation).
# "Federal Republic of Germany" redirects here. For the country from 1949 to 1990',
# government_url: 'https://www.bundesregierung.de/breg-en',
# color: 'Green',
# upcoming_changes: 'N/A')

puts 'create users'

user_1 = User.create!(email: 'test@test.com',
password: "123456",
first_name: 'Kosala',
last_name: 'Doe')

user_2 = User.create!(email: 'test1@test.com',
password: "123456",
first_name: 'Hugo',
last_name: 'Smith')

user_3 = User.create!(email: 'test2@test.com',
password: "123456",
first_name: 'Alex',
last_name: 'Rodrigo')

puts 'done creating users'






