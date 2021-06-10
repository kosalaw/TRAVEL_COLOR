require 'nokogiri'
require 'open-uri'

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
def parse_info(raw_text)
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
    end
    # find TEST
    match_data = content.match(/^(?<name>.*):((.*(?<test>\d{2} hours))?)/)
    if !match_data.nil?
      test = match_data[:test]
    end
    # find QUARANTINE
    match_data = content.match(/^(?<name>.*):((.*(?<quarantine>(\s?quarantine|\s?self-isolate|\s?isolate).*\d{2} days))?)/)
    if !match_data.nil?
      quarantine = match_data[:quarantine]
    end

    # placeholder image url for counrty show page
    url = "https://source.unsplash.com/random?#{name}"

    country_hash = ({
      name: name,
      content: content,
      status: status,
      test: test,
      quarantine: quarantine,
      photo_url: url
    })

    return country_hash
  end
end

def scrape_wanderlust
  puts "Scraping from WANDERLUST"
  url = "https://www.wanderlust.co.uk/content/coronavirus-travel-updates/"
  html_file = URI.open(url).read
  noko_doc = Nokogiri::HTML(html_file)

  countries_array = []
  noko_doc.search("ul > li").each do |element|
    raw_text = element.text.strip

    # check if element contains 2 countries info
    temp_array = []
    match_data = raw_text.match(/^(?<country1>.*:.*)\.(?<country2>.*:.*)\./)
    if !match_data.nil?
      country1 = match_data[:country1]
      country2 = match_data[:country2]
      # for ICELAND only - because Ireland and Iceland are combined in match_data
      country2 = country2[1..-1]

      temp_array << country1
      temp_array << country2
    else
      temp_array << raw_text
    end

    # parse info and add country hash to array
    temp_array.each do |country|
      country_hash = parse_info(country)
      if country_hash == nil
        # p country_hash
      else
        countries_array << country_hash
      end
    end
  end
  return countries_array
end
################################################################################
################################################################################


################################################################################
# UK GOV scraper
################################################################################
def scrape_ukgov
  puts "Scraping from UK GOV"
  url = "https://www.gov.uk/guidance/red-amber-and-green-list-rules-for-entering-england"
  html_file = URI.open(url).read
  noko_doc = Nokogiri::HTML(html_file)
  # p noko_doc

  color_array = []
  noko_doc.search("table").each do |element|
    color = element.search("thead > tr > th:nth-child(1)").text.strip.split(" ")[0]

    element.search("tbody > tr").each do |row|
      name = row.search("th").text.strip
      name = name.split(" (")[0]

      upcoming_changes = row.search("td").text.strip
      # puts "#{color}: #{name} - #{upcoming_changes}"

      if !name.nil? && ARRAY.include?(name)
        # p name

        # sql_query = "name @@ :name"
        # country = Country.where(sql_query, name: "%#{name}%")[0]
        # country.save!

        color_hash = {
          name: name,
          color: color,
          upcoming_changes: upcoming_changes
        }

        color_array << color_hash
      end
    end
  end

  # # Ireland - green
  # ireland = Country.find_by_name("Ireland")
  # ireland[:color] = "Green"
  # ireland.save!


  # # Azores and Madeira - same as Portugal
  # portugal = Country.find_by_name("Portugal")

  # azores = Country.find_by_name("Azores")
  # azores[:color] = portugal[:color]
  # azores[:upcoming_changes] = portugal[:upcoming_changes]
  # azores.save!

  # madeira = Country.find_by_name("Madeira")
  # madeira[:color] = portugal[:color]
  # madeira[:upcoming_changes] = portugal[:upcoming_changes]
  # madeira.save!

  # ARRAY.each do |country|
  #   if !color_array.include?(country)
  #     puts "ERROR! UKgov info not available for: #{country}"
  #   end
  # end

  return color_array

end
################################################################################
################################################################################

def different_to_db?(country_hash, db_country)
  # db_country = Country.find_by_name(country_hash[:name])

  errors_array = []
  # errors_array << db_country

  if db_country[:name] != country_hash[:name]
    puts "Alert: #{db_country[:name]} NAME difference"
    puts "  In DB: " + db_country[:name].to_s
    puts "  Scraped info: " + country_hash[:name].to_s
  end

  if db_country[:content] != country_hash[:content]
    # puts "Alert: #{db_country[:name]} CONTENT difference"
    # puts "  In DB: " + db_country[:content].to_s
    # puts "  Scraped info: " + country_hash[:content].to_s
    content_error = {
      error: "content",
      db: db_country[:content],
      new: country_hash[:content]
    }
    errors_array << content_error
  end

  if db_country[:status] != country_hash[:status]
    # puts "Alert: #{db_country[:name]} STATUS difference"
    # puts "  In DB: " + db_country[:status].to_s
    # puts "  Scraped info: " + country_hash[:status].to_s
    status_error = {
      error: "status",
      db: db_country[:status],
      new: country_hash[:status]
    }
    errors_array << status_error

  end

  if db_country[:test] != country_hash[:test]
    # puts "Alert: #{db_country[:name]} TEST difference"
    # puts "  In DB: " + db_country[:test].to_s
    # puts "  Scraped info: " + country_hash[:test].to_s
    test_error = {
      error: "test",
      db: db_country[:test],
      new: country_hash[:test]
    }
    errors_array << test_error
  end

  if db_country[:quarantine] != country_hash[:quarantine]
    # puts "Alert: #{db_country[:name]} Quarantine difference"
    # puts "  In DB: " + db_country[:quarantine].to_s
    # puts "  Scraped info: " + country_hash[:quarantine].to_s
    quarantine_error = {
      error: "quarantine",
      db: db_country[:quarantine],
      new: country_hash[:quarantine]
    }
    errors_array << quarantine_error
  end

  if db_country[:color] != country_hash[:color]
    # puts "Alert: #{db_country[:name]} COLOR difference"
    # puts "  In DB: " + db_country[:color].to_s
    # puts "  Scraped info: " + country_hash[:color].to_s
    color_error = {
      error: "color",
      db: db_country[:color],
      new: country_hash[:color]
    }
    errors_array << color_error
  end

  if db_country[:upcoming_changes] != country_hash[:upcoming_changes]
    # puts "Alert: #{db_country[:name]} Upcoming_Changes difference"
    # puts "  In DB: " + db_country[:upcoming_changes].to_s
    # puts "  Scraped info: " + country_hash[:upcoming_changes].to_s
    upcoming_changes_error = {
      error: "upcoming_changes",
      db: db_country[:upcoming_changes],
      new: country_hash[:upcoming_changes]
    }
    errors_array << upcoming_changes_error
  end

  # IF THERE ARE CHANGES, SEND OUT ALERTS TO USERS, and update db?
  if errors_array.size >= 1
    puts "-------------------------------------------------------------"
    puts "Sending ALERTS for #{db_country[:name]}"
    puts "-------------------------------------------------------------"

    # SEND ALERTS
    db_country.alerts.each do |alert|
      AlertMailer.with(id: alert.id, error: errors_array).alert.deliver_later
    end

    # AND UPDATE DB WITH NEW INFORMATION????????????? check this with Leonard
    return true

  # ELSE do not update countries ???????? check this with Leonard
  else
    return false
  end
end


puts "RAKE FILE ------------"
namespace :countries do
  desc "Scraping country data from WL and UKG"
  task scrape: :environment do
    countries_array = scrape_wanderlust
    # p countries_array.size
    color_array = scrape_ukgov
    # p color_array.size

    puts "Combining information"
    countries_array.each do |country_hash|
      color_array.each do |color_hash|
        if country_hash[:name] == color_hash[:name]
          country_hash[:color] = color_hash[:color]
          country_hash[:upcoming_changes] = color_hash[:upcoming_changes]
        end
      end
      # p country_hash
    end

    puts "Checking for changes"
    countries_array.each do |country_hash|
      db_country = Country.find_by_name(country_hash[:name])

      # if different, update db with new info
      if different_to_db?(country_hash, db_country) == false

        # db_country[:name] = country_hash[:name]
        # db_country[:content] = country_hash[:content]
        # db_country[:status] = country_hash[:status]
        # db_country[:test] = country_hash[:test]
        # db_country[:quarantine] = country_hash[:quarantine]
        # db_country[:color] = country_hash[:color]
        # db_country[:upcoming_changes] = country_hash[:upcoming_changes]
        # db_country.save!
      end
    end
  end
end



































