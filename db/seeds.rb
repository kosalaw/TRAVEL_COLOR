require "open-uri"

Country.destroy_all
User.destroy_all

puts 'create countries'

country_1 = Country.create!(name: 'France',
iso: 'French',
status: 'Open',
quarantine: 'Yes',
test: 'Yes',
content: 'La France" redirects here. For other uses of "La France", see Lafrance. For other uses of "France", see France (disambiguation).',
government_url: 'https://www.gouvernement.fr/en/news',
color: 'Amber',
upcoming_changes: 'N/A')

country_2 = Country.create!(name: 'Italy',
iso: 'it',
status: 'Closed',
quarantine: 'Yes',
test: 'Yes',
content: 'Italy applies health-related restriction measures to incoming travellers, which may vary depending on their country of origin.',
government_url: 'http://www.italia.it/en/useful-info/covid-19-updates-information-for-tourists.html',
color: 'Red',
upcoming_changes: 'N/A')

country_3 = Country.create!(name: 'Germany',
iso: 'German',
status: 'Closed',
quarantine: 'Yes',
test: 'No',
content: 'This article is about the country. For other uses, see Germany (disambiguation) and Deutschland (disambiguation).
"Federal Republic of Germany" redirects here. For the country from 1949 to 1990',
government_url: 'https://www.bundesregierung.de/breg-en',
color: 'Green',
upcoming_changes: 'N/A')

puts 'done creating countries'
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
